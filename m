Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264964AbSJPIqS>; Wed, 16 Oct 2002 04:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSJPIqS>; Wed, 16 Oct 2002 04:46:18 -0400
Received: from barclay.balt.net ([195.14.162.78]:6831 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S264964AbSJPIqQ>;
	Wed, 16 Oct 2002 04:46:16 -0400
Date: Wed, 16 Oct 2002 10:49:08 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: linux-kernel@vger.kernel.org
Subject: sendfile(2) behaviour has changed ?
Message-ID: <20021016084908.GA770@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This sample code copies a file using sendfile(2) call works just fine on 
2.2.x and 2.4.x kernels. On 2.5.x kernels (not sure starting which
version) it stopped working. Program terminates with EINVAL error. 

$ ./sendfile
sendfile: Invalid argument

Is this expected behaviour ? that sendfile(2) on 2.5.4x linux kernel requires
socket as an output fd paramter ? 

Was it ever legal to copy file(s) on filesystem using sendfile(2) ?
(which was kindda nice feature ... )

--y0ulUmNC+osPPQO6
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="sendfile.c"

#include <sys/sendfile.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main() 
{
	int fd_in  = 0;
	int fd_out = 0;
	struct stat stat_buf;
	off_t  offset = 0;
	ssize_t count = 0;

	if ((fd_in=open("sendfile.c",O_RDONLY))<0)
	{
		perror("open");
		exit(1);
	}
	if ((fd_out=open("sendfile.out",O_CREAT|O_TRUNC|O_WRONLY,S_IRWXU))<0)
	{
		perror("open");
		exit(1);
	}

	if (fstat(fd_in,&stat_buf)) {
		perror("fstat");
	}


	count = sendfile(fd_out,fd_in,&offset,stat_buf.st_size);

	if (count < 0)
		perror("sendfile");
	
	if (close(fd_in) < 0)
		perror("close");
	if (close(fd_out) < 0)
		perror("close");
	return 0;
}


--y0ulUmNC+osPPQO6--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVK0S5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVK0S5s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVK0S5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:57:48 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:2176 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750760AbVK0S5s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:57:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MnzRPt4tQlUts7nXMDHywJjsc/K9nN13EEH1CroKS0jNnaGroc1Q6kvn+2/IL4fY+ieB1/VpAD1QbsBr/fXGzntVl9dyrjw9gOrkE6vIYbeYhiH8Jep/CeN1co/VEI0qcItaa+AFAB27UhTpOvHiZ9RKPJBrVzFFoyikxcrJYJA=
Message-ID: <afd776760511271057l5e3c4e3fq14b0b9ba4cdc7c9a@mail.gmail.com>
Date: Sun, 27 Nov 2005 12:57:47 -0600
From: Mohamed El Dawy <msdawy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: What's wrong with this really simple function?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have created this 5-liner system call, which basically opens a
file, write "Hello World" to it, and then returns. That's all.

Now, when I actually call it, it creates the file successfully but
writes nothing to it. The file is created and is only zero bytes. So,
either write didn't write, or close didn't close. Any help would be
greatly appreciated.

#define SUCCESS 0
#define CANT_OPEN_FILE 1
#define YOU_ARE_NOT_ROOT 3
#define OTHER_STUPID_ERROR 4

asmlinkage long sys_dump(char * filename)
{
    int fd;
    if(!capable(CAP_SYS_ADMIN))
        return YOU_ARE_NOT_ROOT;

    fd=sys_open(filename,O_CREAT|O_WRONLY|O_TRUNC,S_IRWXU);
    if(fd==-1)
        return CANT_OPEN_FILE;

    if(sys_write(fd,"Hello World From inside the kernel!",35)==0)
    {
        sys_close(fd);
        return OTHER_STUPID_ERROR;
    }

    sys_close(fd);
    return SUCCESS;
}

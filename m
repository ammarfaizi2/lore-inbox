Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTKJLeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTKJLeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:34:02 -0500
Received: from postino1.roma1.infn.it ([141.108.26.15]:25228 "EHLO
	postino1.roma1.infn.it") by vger.kernel.org with ESMTP
	id S263205AbTKJLd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:33:58 -0500
Message-ID: <3FAF77A5.60607@roma1.infn.it>
Date: Mon, 10 Nov 2003 12:33:57 +0100
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en, it
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OT: why no file copy() libc/syscall ??
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (postino1.roma1.infn.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it may be orribly RTFM... but writing a simple framework I realized 
there is no libc/POSIX/whoknows
copy(const char* dest_file_name, const char* src_file_name)

What is the technical reason???

I understand that there may be little space for kernel side 
optimizations in this area but anyway I'm surprised I have to write

< the bits to clone the metadata of src_file_name on opening 
dest_file_name >
const int BUFSIZE = 1<<12;
char buffer[BUFSIZE];
int nrb;
while((nrb = read(infd, buffer, BUFSIZE) != -1) {
  ret = write(outfd, buffer, nrb);
  if(ret != nrb) {...}
}

instead of something similar to:
sys_fscopy(...)

regards




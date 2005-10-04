Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVJDO0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVJDO0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVJDO0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:26:24 -0400
Received: from mx1.cdacindia.com ([203.199.132.35]:26040 "HELO
	mailx.cdac.ernet.in") by vger.kernel.org with SMTP id S932488AbVJDO0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:26:23 -0400
Message-ID: <434288E9.3090108@cdac.in>
Date: Tue, 04 Oct 2005 19:21:37 +0530
From: Karthik Sarangan <karthiks@cdac.in>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Using DMA in read/write, setting block size for I/O
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my application, I have the following code.

int main(void)
{
    char *pcBuffer;

    posix_memalign((void **) pcBuffer, 512, 262144);
    int ifd = open("/dev/sdb", O_DIRECT | O_RDWR);
    long lLen;

    lLen = read(ifd, pcBuffer, 262144);
   
    close(ifd);
    return 0;
}

Will the underlying block device read a single 256KB block from the hdd 
into pcBuffer
or will it read 256KB as a set of smaller blocks?

Since the buffer is memory aligned will it enable DMA?

scsi disk driver is adaptec aic79xx.o
distro is RedHat Enterprise Linux WS 4 (kernel-2.6.9-11)

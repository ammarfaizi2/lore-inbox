Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbUKWCZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUKWCZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUKWCYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:24:05 -0500
Received: from web50510.mail.yahoo.com ([206.190.38.247]:36971 "HELO
	web50510.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261167AbUKWCWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:22:09 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=dCLi3Nj8oRpYtqd4cbbPjJgC6qx1ZK8UoQXGO8JCowi1xG2M2bNvbPrmZQDhly+FRSX6maPWQvgBByXP9c+7fTFKsJhgwhDwMffcACUdSpdh6SciRegidXwbPVvbKVgFTixc9yQF3/sX953iFsOK2S+NAoLNjLaciJ+tdoIKU4A=  ;
Message-ID: <20041123022205.87438.qmail@web50510.mail.yahoo.com>
Date: Mon, 22 Nov 2004 18:22:05 -0800 (PST)
From: lan mu <mu8lan2003@yahoo.com>
Subject: kiobuf issue/question - urgent please help!
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi experts,
 
I tried to pass 620000 bytes data which collected from
FPGA and store 
in Kernal to user application.
 
I have tried kiobuf as below:
 
in linux driver:
==========
static unsigned long gPages[152]; /* page size=4096 */
 
in the mydriver_read()
===================

unsigned char *ptr;


    /* Allocate an I/O vector */
    result = alloc_kiovec(1, &iobuf);
    if (result)
    {
        printk("Error: alloc_kiovec return error
!!!\n");
        return -EFAULT;
    }
    // kiobuf_init(iobuf);

    /* Map the user I/O buffer and read to do the I/O.
*/
     result = map_user_kiobuf(READ, iobuf, (unsigned
long) buf, count);
    if (result) {
        free_kiovec(1, &iobuf);
        printk("Error: map_user_kiobuf return error
!!!\n");
        return -EFAULT;
    }
    printk("nr_pages == %d\noffset == %d\nlength ==
%d\n", 
iobuf->nr_pages, iobuf->offset, iobuf->length);

    for(i = 0; i < iobuf->nr_pages; i++)
    {

       gPages[i] = page_address(iobuf->maplist[i]);
       printk("gPages[%d] == 0x%x\n", i,gPages[i]);
 
       for (j=0; j<4096; j++)
         ptr[j] = i;
    }

 /* unmap the user buffer */
    unmap_kiobuf(iobuf);
    free_kiovec(1, &iobuf);

User application will pass buf with 620000 allocated
in user space.
 
Issue:
Actually I have got 152 pages with valid addresses and
when I ran user 
application, I can see the data I have assigned in
driver space and 
seems like okay.
 
But after intensive testing, I found some value that I
read in user app 
is not corrrect (system not crash though). 
 
Question:
=======
After I got page addresses, can I just use it as the
start point to 
write 4096 bytes data in that page, or I have to do
something extra? 
like 
check sectors and etc? If so, can anyone give me an
example?
 
Please help!
Many thanks!
 
-Lan



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

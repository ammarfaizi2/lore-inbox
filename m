Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTDUSH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDUSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:07:56 -0400
Received: from web8002.mail.in.yahoo.com ([203.199.70.20]:48216 "HELO
	web8005.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S261809AbTDUSHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:07:54 -0400
Message-ID: <20030421181951.98096.qmail@web8005.mail.in.yahoo.com>
Date: Mon, 21 Apr 2003 11:19:51 -0700 (PDT)
From: =?iso-8859-1?q?Yours=20Lovingly?= <ylovingly@yahoo.co.in>
Subject: Qn: Queer error in kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have a small hack for the linux kernel's nfs
module which was working just fine before the
following code was introduced:

static void nfs_print_path(struct dentry *d) {
	struct dentry *parent;
	struct inode *inode_parent, *inode;
	unsigned long p, me;

	if(!d) {
		return;
	}	
	parent = d->d_parent;
	
	if(parent) {
		inode_parent = parent->d_inode;
		inode = d->d_inode;
// till here everything works just fine
		
/* the following code just doesn't work. None of it
works, neither the assignments to 'p' and 'me', nor
the printk, nor the comparision in the if statement
after that. I tested each of these 3 different cases
separately and each time i got the same error (see
below) */
                p = (unsigned long)inode_parent;
		me = (unsigned long)inode;

		printk("parent inode: %x child inode: %x\n",
inode_parent, inode);

                if( ((char *)inode_parent == 
                              (char *)inode) ) { 
		       
............
}


I got an error something like this: 
Unable to handle kernel NULL pointer dereference at
virtual address 0...0f 
printing eip ....
		

As i see it, if there is really an error where it
appears to be to me, there is error in just 'reading'
the values of the variable 'inode_parent' and 'inode'.
But considering the object code the C Compiler must
have produced, there is nothing that actually *does*
some real task - all that is being done is reading
some
arbit value from the function's stack: whats so wrong
with that ???

thanks in advance
abhishek


__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com

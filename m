Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVAAIIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVAAIIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 03:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVAAIIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 03:08:53 -0500
Received: from web52201.mail.yahoo.com ([206.190.39.83]:13473 "HELO
	web52201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262196AbVAAIIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 03:08:49 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=xicYMAzl+cxhxo5MXYypjeoDSY0tndrIdawD6ivEs4kpxMYVHd1v2PFUs4OuuALdY8rrN1PQMMbeuW5eFBPUBEBwqUUdaUz013Mw1mhvy77GbmJbvV5L6/5X9CcQiqJzD6gLbYxQDvknDXehdqjOgCS34IVWcoamQdHXH/atBPs=  ;
Message-ID: <20050101080849.56155.qmail@web52201.mail.yahoo.com>
Date: Sat, 1 Jan 2005 00:08:49 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: Is my module program is giving correct output?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
          While writing kernel module packet sniffer i
start with first accessing packets length 
and its data part.so, to start i try to access packet
data first and copy it to other variable to dump
its contents but i am facing a problem while accessing
the packet's data. As i have studied i 
found that data in packet at any layer resides in
between data and tail pointers.  So if i
have to print it or copy it in any unsigned string
then how to do that?
          I tried with following example which
receives packet and print data part at IP layer. But I
am not sure whether am i getting packet dump or
address of string packet?
Thanks in advance.
regards,
linux_lover

#define MODULE
#define __KERNEL__

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/skbuff.h>
#include <linux/ip.h>
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>

#include <linux/string.h>

static struct nf_hook_ops nfho;

unsigned int hook_func(unsigned int hooknum,struct
sk_buff **skb,
                                 const struct
net_device *in,
                                 const struct
net_device *out,
                                 int (*okfn)(struct
sk_buff *))
{
  struct sk_buff *sb = *skb;
  printk(KERN_DEBUG "calling hook_func at
NF_IP_LOCAL_OUT\n");
      unsigned char *packet;
      unsigned int buflen;
      int  i=0;
      buflen=sb->len;
      packet=kmalloc(buflen,GFP_USER);
      memset(packet,'\0',buflen);
      printk(KERN_DEBUG "Length of skb->data in hook
function = %d\n", buflen);
      strncpy(packet,sb->data,buflen);
      printk(KERN_DEBUG "packet contents of sb->data
in hook function = %x\n", packet);

     return NF_ACCEPT;
}

static int __init init(void)   
  {
              nfho.hook     = hook_func;
              nfho.hooknum  = NF_IP_LOCAL_OUT;
              nfho.pf       = PF_INET;
              nfho.priority = NF_IP_PRI_FIRST;
              nf_register_hook(&nfho1);
              return 0;
          }

static void __exit fini(void)
          {
              nf_unregister_hook(&nfho1);
          }
module_init(init);
module_exit(fini);
MODULE_LICENSE("GPL");


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250

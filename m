Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRC0Qad>; Tue, 27 Mar 2001 11:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRC0QaY>; Tue, 27 Mar 2001 11:30:24 -0500
Received: from [192.118.128.39] ([192.118.128.39]:20239 "HELO
	sol.aladdin.co.il") by vger.kernel.org with SMTP id <S131407AbRC0QaS>;
	Tue, 27 Mar 2001 11:30:18 -0500
Subject: problem with ip_rcv()
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFCBFF5C94.FFD930D8-ON42256A1C.00580271@aladdin.co.il>
From: Andrey.Kondakov@eAladdin.com
Date: Tue, 27 Mar 2001 18:29:51 +0200
X-MIMETrack: Serialize by Router on SOL/AKS(Release 5.0.5 |September 22, 2000) at 03/27/2001
 06:29:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I try to develop driver that has to catch all incomming traffic and proceed
it.

I use register_firewall() function that registers three functions:
in_check, out_check, forward_check.
There is call to register_firewall in my driver's init_module().
So, in in_check() I receive packet and give it to my processing function
Parse() that makes decision
regarding to the packet:
- to let it in and calls to ip_rcv(skb, skb->dev, NULL);
- to block it.

Always in_check returns FW_BLOCK.

The problem is when I call to ip_rcv() my computer is hanged up. All I see
is printing log after
function Parse().

Below is cut of my source.

int Parse(struct sk_buff * skb)
{
     [ packet analyze ]

     if ( packet may enter ) return ip_rcv(skb, skb->dev, NULL);

     else
     {
          kfree_skb(skb);
          return BLOCKED;
     }
}

int in_check(struct firewall_ops *this, int pf, struct device *dev,
               void *phdr, void *arg, struct sk_buff **pskb)
{
     int res;

     ip_statistics.IpInReceives--;

     res = Parse(*pskb);
     printk(...);
     if(res == BLOCKED)
     {
     [ something ]
     }

     return FW_BLOCK;
}

What ip_rcv() has to return? Do I do everything right? Is there maybe
common way to perform such a trik?

Thanks a lot.

Andrey


******************************* IMPORTANT ! **********************************
The content of this email and any attachments are confidential and intended 
for the named recipient(s) only.

If you have received this email in error please notify the sender immediately.
Do not disclose the content of this message or make copies.

This email was scanned by eSafe Mail for viruses, vandals  and other
malicious content.
******************************************************************************


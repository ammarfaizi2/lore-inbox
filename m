Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312834AbSDXXpi>; Wed, 24 Apr 2002 19:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312846AbSDXXpi>; Wed, 24 Apr 2002 19:45:38 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:65412 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S312834AbSDXXph>; Wed, 24 Apr 2002 19:45:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: Donald Becker <becker@scyld.com>
Subject: Via-Rhine Driver - questions for D. Becker.
Date: Wed, 24 Apr 2002 17:39:08 -0600
X-Mailer: KMail [version 1.2]
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02042417390802.00760@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to debug the kernel Via-Rhine driver but I do not have 
much information and I'm forced to guess about many things.

Since you are the original author, I wanted to ask you some questions about 
the operation of the driver. If you have time, your help would be greatly 
appreciated.

(btw. I am aware that you have your own version of the driver.
However most issues will probably apply to that driver as well. )

Here are my questions:

- 1) "Something wicked happened"]
What is the precise purpose of the trap - what should be trapped and what 
shouldn't. Is it even necessary? There are a definite number of interrupts to 
call via_rhine_error - why not simply handle each one of them? I've seen 3 
different versions of the "wicked" code. 

- 2) CmdTxDemand should be issued to handle which error interrupts?

- 3) Missing interrupts in setting the bitmask....
Is there a reason or is it an error? some of those are used later in the 
code... RxNoBuf for example, RxOverflow is another (actually your driver 
includes that but never uses it), TxAborted is missing in both kernel and 
your version.

- 4) RxOverflow is not handled. Does it need to be and how?

-5 ) What is a good resource on those things? I read the datasheets.
They give useful numbers but little explanation on how different interrupts 
should be handled. What info did you have when you were writing the driver.  

-6) TxUnderrun - it increases threshold and then issues CmdTxDemand in  the 
"wicked error" trap. The linuxfet VIA driver, additionally  does the 
following: Sets descriptor bit, CmdTxOn, CmdTxDemand

if (txstatus & 0x0800) {
                    /* uderrun happen */
                    np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
                    writel(virt_to_bus(&np->tx_ring[entry]), ioaddr + 
TxRingPtr);
                    /* Turn on Tx On*/
                    writew(CmdTxOn | np->chip_cmd, dev->base_addr + ChipCmd); 
  

                    /* Stats counted in Tx-done handler, just restart Tx. */
                    writew(CmdTxDemand | np->chip_cmd, dev->base_addr + 
ChipCmd)
;
                    if (debug > 1)
                       printk(KERN_ERR "Underrun happen");

Is it necessary to do the above on underruns?

That's all for now.
I have tried to figure those things out on my own but
the main problem is lack of any resource to help me.
I haven't written any network drivers so I am unfamiliar with 
what every interrupt does and how. if you can point me to some documentation 
for help maybe I could figure it out myself. 

Thank you for your help.
This message will be cc'd to LKML as well.



 

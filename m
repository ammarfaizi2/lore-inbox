Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290205AbSAWX0v>; Wed, 23 Jan 2002 18:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290206AbSAWX0m>; Wed, 23 Jan 2002 18:26:42 -0500
Received: from ns.ithnet.com ([217.64.64.10]:44810 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S290205AbSAWX0b>;
	Wed, 23 Jan 2002 18:26:31 -0500
Message-Id: <200201232325.AAA12824@webserver.ithnet.com>
Cc: Urban Widmark <urban@teststation.com>,
        Martin Eriksson <nitrax@giron.wox.org>,
        Justin A <justin@bouncybouncy.net>, Andy Carlson <naclos@swbell.net>,
        linux-kernel@vger.kernel.org
Date: Thu, 24 Jan 2002 00:25:53 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <3C4F20A5.F88EA471@zip.com.au>
Content-Transfer-Encoding: 7BIT
Subject: Re: via-rhine timeouts
To: Andrew Morton <akpm@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Urban Widmark wrote:                                                
> >                                                                   
> >     writeb(readb(ioaddr + TxConfig) | 0x80, ioaddr + TxConfig);   
> >     np->tx_thresh = 0x20;                                         
> > (linuxfet.c)                                                      
> >                                                                   
> >         writeb(0x20, ioaddr + TxConfig);                          
> >         np->tx_thresh = 0x20;                                     
> > (via-rhine.c)                                                     
> >                                                                   
> > Note how the linuxfet driver sets a higher value but does not make
the                                                                   
> > tx_thresh follow, so if it later gets a "IntrTxUnderrun" it will  
lower the                                                             
> > threshold. But the chosen value is probably large enough.         
> >                                                                   
> > Those of you with this problem could try changing the 0x80 to 0x20
in the                                                                
> > linuxfet.c driver and see if the problem returns (or the other way
around                                                                
> > in the via-rhine.c driver).                                       
> >                                                                   
>                                                                     
> That would certainly explain why people are seeing success          
> with linuxfet.                                                      
>                                                                     
> Here's the test patch which you describe.  It would be              
> useful if people could try it..                                     
                                                                      
Forgive me being stupid, but shouldn't the comment behind follow      
somehow?                                                              
I may be dead wrong, but you're increasing the initial treshold here, 
or not?                                                               
Please ignore me if I am way off.                                     
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
--- linux-2.4.18-pre6/drivers/net/via-rhine.c	Tue Jan 22 12:38:30 2002
+++ linux-akpm/drivers/net/via-rhine.c	Wed Jan 23 12:42:18 2002       
@@ -965,7 +965,7 @@ static void init_registers(struct net_de          
 	/* Initialize other registers. */                                   
 	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */  
 	/* Configure the FIFO thresholds. */                                
-	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */   
+	writeb(0x80, ioaddr + TxConfig);	/* Initial threshold 128 bytes */  
 	np->tx_thresh = 0x20;                                               
 	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */   
                                                                      
                                                                      

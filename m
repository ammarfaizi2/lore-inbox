Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316644AbSFDTpx>; Tue, 4 Jun 2002 15:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSFDTpw>; Tue, 4 Jun 2002 15:45:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47744 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316643AbSFDTpt>;
	Tue, 4 Jun 2002 15:45:49 -0400
Date: Tue, 04 Jun 2002 12:42:41 -0700 (PDT)
Message-Id: <20020604.124241.78709149.davem@redhat.com>
To: mochel@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0206041227410.654-100000@geena.pdx.osdl.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Mochel <mochel@osdl.org>
   Date: Tue, 4 Jun 2002 12:38:06 -0700 (PDT)

   
   > There's this middle area between core and subsys, why not
   > just be explicit about it's existence?
   > 
   > Short of making the true dependencies describable, I think my
   > postcore_initcall solution is fine.
   
   What sense is there in naming it postcore_initcall? What does it tell you 
   about the intent of the function? 
   
It says "this has to be initialized, but after core initcalls because
it expects core to be setup."  That's what "postcore" means. :-)

   The initcall levels are not a means to bypass true dependency resolution. 
   They're an alternative means to solving some of the dependency problems 
   without having a ton of #ifdefs and hardcoded, explicit calls to 
   initialization routines. 
   
I added no ifdefs, what are you talking about.

   We can add more levels and change names. But, we should make them 
   meaningful for at least two reasons:
   
   - It's obvious to people who are using them what they should use
   - It's obvious to someone looking at the code when it gets initialized
   
How much more meaning do you want than "this requires core to be
setup"  That describes a lot to me.

   That said, how about doing this:
   
   - core

+- postcore

   - subsys
   - arch
   - driver
   
   core initializes the core, as always.
   
   subsys initializes bus and device class subsystems and registers them with 
   the core.
   
But there are things between subsys and core as demonstrated by the
very bug we are trying to fix right now.

You people are blowing this shit WAY out of proportion.  Just fix the
bug now and reinplement the initcall hierarchy in a seperate changeset
so people can actually get work done in the 2.5.x tree while you do
that ok?

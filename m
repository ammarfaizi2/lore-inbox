Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265435AbSJaWcE>; Thu, 31 Oct 2002 17:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265441AbSJaWbq>; Thu, 31 Oct 2002 17:31:46 -0500
Received: from ulima.unil.ch ([130.223.144.143]:2694 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S265435AbSJaWaa>;
	Thu, 31 Oct 2002 17:30:30 -0500
Date: Thu, 31 Oct 2002 23:36:56 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 : kernel BUG at kernel/workqueue.c:69! (ISDN?)
Message-ID: <20021031223656.GA25956@ulima.unil.ch>
References: <20021031215441.GD24890@ulima.unil.ch> <Pine.LNX.4.44.0210311620470.27728-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0210311620470.27728-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 04:24:27PM -0600, Kai Germaschewski wrote:

> Well, since I obviously hadn't, thanks for reporting this ;)

That's a pleasure ;-)

> These traces still have a lot of weird things in it, but I think I figured 
> out what went wrong now. As a workaround, the following should do.
> 
> ===== drivers/isdn/hisax/avm_pci.c 1.11 vs edited =====
> --- 1.11/drivers/isdn/hisax/avm_pci.c	Tue Oct 29 19:50:48 2002
> +++ edited/drivers/isdn/hisax/avm_pci.c	Thu Oct 31 16:19:26 2002
> @@ -731,10 +731,10 @@
>  			release_region(cs->hw.avm.cfg_reg, 32);
>  			return(0);
>  		case CARD_INIT:
> -			clear_pending_isac_ints(cs);
>  			initisac(cs);
> -			clear_pending_hdlc_ints(cs);
> +			clear_pending_isac_ints(cs);
>  			inithdlc(cs);
> +			clear_pending_hdlc_ints(cs);
>  			outb(AVM_STATUS0_DIS_TIMER | AVM_STATUS0_RES_TIMER,
>  				cs->hw.avm.cfg_reg + 2);
>  			WriteISAC(cs, ISAC_MASK, 0);

I'll try ;-)

> Anyway, actually, this driver has been superseded by hisax_fcpcipnp, so 
> I'd prefer if you used the new driver ("modprobe hisax_fcpcipnp", no 
> parameters necessary), to find bugs there. Also, be advised that this is 
> not the last bug you'll find in current 2.5 ISDN, but I'll be thankful for 
> any reports and testing ;)

I'll compile that way now ;-)

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

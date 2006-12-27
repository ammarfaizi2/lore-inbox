Return-Path: <linux-kernel-owner+w=401wt.eu-S964819AbWL0X7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWL0X7G (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 18:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWL0X7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 18:59:06 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:41503 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964819AbWL0X7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 18:59:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=KOhhz8JFjMau4wZ96V1SXKP2zt8LLnNiRy0K9IKoJnOcTatuCFL/eUc/4Xpd0F+PwZhjr+w7Yz3BCk8v4X+bnL+h5BK0ehW/cJiLXOY8l2qRt9NFTRKz360FaHx/LScAp8lXwIkwwrYfdoYlSMF38nTu2mFdjBWOsAwKm6XOPO8=  ;
X-YMail-OSG: bILa.GsVM1l2qVM18anOzzXQl8IV11vvPv9HBuHOnVAUAGF.ihFpMz_fmiqedUuoZCV6Z9Dt796jmYK0a5Qsg3FVkIzL7QRtAK3EZlZy1YbyHnZ611ZmZ32Bg5pX2SS9NDEBm7amTTmegxU14cpikX1LzVo8Up1pGUWBvoOISls0Wm27OvO9IE2Q7H.Y
From: David Brownell <david-b@pacbell.net>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 2.6.12-rc2] PNP: export pnp_bus_type
Date: Wed, 27 Dec 2006 15:59:00 -0800
User-Agent: KMail/1.7.1
Cc: Adam Belay <abelay@novell.com>, ambx1@neo.rr.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200612271347.47114.david-b@pacbell.net> <1167258618.3281.4112.camel@laptopd505.fenrus.org>
In-Reply-To: <1167258618.3281.4112.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612271559.02077.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 2:30 pm, Arjan van de Ven wrote:
> On Wed, 2006-12-27 at 13:47 -0800, David Brownell wrote:
> > The PNP framework doesn't export "pnp_bus_type", which is an unfortunate
> > exception to the policy followed by pretty much every other bus.  I noticed
> > this when I had to find a device in order to provide its platform_data.
> 
> can you please merge the export together with the driver? 

I'll send that stuff along; providing the platform data is actually
an update to ACPI glue, not the driver, so the driver won't need to
become needlessly coupled to ACPI.  (Driver = rtc_cmos, I'll resend
it in a few days.)


> We already 
> have way too many unused exports, and the only sane way is to merge the
> export with the user..... (and yes exports are not free, they take up
> 100 to 150 bytes of kernel size for example)

Hmm, then maybe it'd be worth updating that patch I just sent so that
the only change is to switch #includes for the extern decl ... i.e. to
"export" it only to other statically linked kernel code, rather than to
modules.  I'll do that.

My own question about that EXPORT_SYMBOL was whether it instead be
an EXPORT_SYMBOL_GPL, but if either one costs bytes ... I'm happy to
avoid that cost!

- Dave

  

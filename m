Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423037AbWJaO0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423037AbWJaO0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423352AbWJaO0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:26:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:43246 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423037AbWJaO0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:26:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Q4jy2yoKxSbcBVDqWSLD4ivkMrGzD3BqGj3CPuudr3Tc4XqgsLV1FTwW2lxg/i41sCoO3U3STh1Fs43jM8osLWyW8Lbhj3TcGekD4kRGjhFPML6MOt+e0tVsrRnplbS9141ccqGYr50SAb0MEU+Anfo7zHKeJuHd/11yCqMuG6w=
Message-ID: <f46018bb0610310626u5e99bebfj9aa602a26a9f1387@mail.gmail.com>
Date: Tue, 31 Oct 2006 09:26:32 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: "Uli Kunitz" <kune@deine-taler.de>
Subject: Re: [PATCH] wireless-2.6 zd1211rw check against regulatory domain rather than hardcoded value of 11
Cc: "Johannes Berg" <johannes@sipsolutions.net>,
       "Daniel Drake" <dsd@gentoo.org>, zd1211-devs@lists.sourceforge.net,
       linville@tuxdriver.com, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, holdenk@xandros.com
In-Reply-To: <454683D1.4030200@deine-taler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f46018bb0610231121s4fb48f88l28a6e7d4f31d40bb@mail.gmail.com>
	 <453D48E5.8040100@gentoo.org>
	 <f46018bb0610240709y203d8cdbw95cdf66db23aa1ce@mail.gmail.com>
	 <453E2C9A.7010604@gentoo.org> <4544CBC8.5090305@deine-taler.de>
	 <1162197749.2854.5.camel@ux156> <454683D1.4030200@deine-taler.de>
X-Google-Sender-Auth: 36383b3961ef9e1f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch was based off the FIXME comment in the code [which suggested
replacing 11 with the boundary for the regulatory domain]. I'll take a
look at the vendors driver and see about modifying the patch to fit
more with its logic or just limmiting it to the FCC regulatory domain.

On 10/30/06, Uli Kunitz <kune@deine-taler.de> wrote:
> Johannes Berg wrote:
> >> I'm not so sure about this. This patching might be US-specific and we
> >> cannot simply apply the setting for top channel of another domain
> >> instead of channel 11. One option would be to set the value only under
> >> the US regulatory domain.
> >
> > ??
> > What the patch does is replace the top channel which is hardcoded to 11
> > by the top channel given by the current regulatory domain. How can that
> > be wrong? Except that you may want to init the regulatory domain from
> > the EEPROM but I'm not sure how the ieee80211 code works wrt. that.
> >
> > johannes
>
> The problem is not so much that I don't trust the geo code, but whether
> setting the register to that band-edge value for a higher channel is
> the right thing to do. It looks like that this is a hack for FFC
> compliance. Therefore I suggest to patch CR128 only
> for the US regulatory domain.
>
> Here is the code from the GPL vendor driver (zdhw.c):
>
>     if (pObj->HWFeature & BIT_21)  //6321 for FCC regulation, enabled HWFeature 6M band edge bit (for AL2230, AL2230S)
>      {
>          if (ChannelNo == 1 || ChannelNo == 11)  //MARK_003, band edge, these may depend on PCB layout
>          {
>              pObj->SetReg(reg, ZD_CR128, 0x12);
>              pObj->SetReg(reg, ZD_CR129, 0x12);
>              pObj->SetReg(reg, ZD_CR130, 0x10);
>              pObj->SetReg(reg, ZD_CR47, 0x1E);
>          }
>          else //(ChannelNo 2 ~ 10, 12 ~ 14)
>          {
>              pObj->SetReg(reg, ZD_CR128, 0x14);
>              pObj->SetReg(reg, ZD_CR129, 0x12);
>              pObj->SetReg(reg, ZD_CR130, 0x10);
>              pObj->SetReg(reg, ZD_CR47, 0x1E);
>          }
>      }
>
> The patch from Holden would set ZD_CR128 to 0x12 for the highest channel,
> which would not reflect the logic of the vendor driver.
>
> Kind regards,
>
> Uli
>
> --
> Uli Kunitz (kune@deine-taler.de)
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Cell: 613-276-1645

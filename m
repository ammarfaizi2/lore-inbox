Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967550AbWK2Sz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967550AbWK2Sz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 13:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967549AbWK2Sz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 13:55:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:54570 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S967550AbWK2Sz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 13:55:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o5Us9LxMyogFbtQTG5cgJlrtj1VeicNRy4/8sQo7r6wzWQjzFMP1t/eI4l5vTCd2coR9kfgouOue51PI/JcfIUW3OgIaKDif59aTmO8wW4Gy7QqJr0kpERIJAizFG6gmj+HkHTx3WbqpXpKQ78bP5wPCCzT1LHZfKld9sE9t2vQ=
Message-ID: <4807377b0611291055o6e28c66ft9edeb3c8363dd49b@mail.gmail.com>
Date: Wed, 29 Nov 2006 10:55:54 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: Re: Intel 82559 NIC corrupted EEPROM
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com, bunk@stusta.de, jgarzik@pobox.com,
       saw@saw.sw.com.sg
In-Reply-To: <456D6E5C.4040805@privacy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com>
	 <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net>
	 <4807377b0611080926x21bd6326xc5e7683100d20948@mail.gmail.com>
	 <45533801.7000809@privacy.net>
	 <4807377b0611271234l131bf7d7l975ed7e46d8c7444@mail.gmail.com>
	 <456D6E5C.4040805@privacy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, John <me@privacy.net> wrote:
> > Let's go ahead and print the output from e100_load_eeprom
> > debug patch attached.
>
> Loading (then unloading) e100.ko fails the first few times (i.e. the
> driver claims one of the EEPROMs is corrupted). Thereafter, sometimes it
> fails, other times it works. Sounds like a race, no?

yes, or something like that.  I think you may have a piece of eeprom
hardware that is either "slow" or slightly out of spec.  I wonder if
the hrt kernel makes udelay(4) much more like 4us than the regular
kernels.

can you try adding mdelay(100); in e100_eeprom_load before the for loop,
and then change the multiple udelay(4) to mdelay(1) in e100_eeprom_read

> On an unrelated note, insmod_100.txt is truncated at the beginning, and
> insmod_110.txt is truncated in the middle (!!) cf. line 14. What would
> cause klogd to behave like that?

usually its because whatever is printing is printing too fast or too
much at a time.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWIKTBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWIKTBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWIKTBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:01:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:43130 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964948AbWIKTBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:01:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=txGCnvquOWLoO44MtC7JZw3f/Bi7Eg69sSDDb/cmv/Fmqz280M4R7F+Fgdn0uNcjWerlFa6P6/6l+1nj6shtdk/MrQTXfvn+TNCY4M1B9tHIV3qhSzIuYgBiVOId5I8JQZRilv/iK/CDCF5JaL0oM4B6NCoDhqX1CVSFHVCvdBc=
Message-ID: <d120d5000609111201x6d901d2do5d3c2eb934930e4f@mail.gmail.com>
Date: Mon, 11 Sep 2006 15:01:35 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: [RFC] OLPC tablet input driver, take two.
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Marcelo Tosatti" <mtosatti@redhat.com>
In-Reply-To: <20060911182733.GR4181@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060829073339.GA4181@aehallh.com>
	 <20060910201036.GD4187@aehallh.com>
	 <200609101819.32176.dtor@insightbb.com>
	 <20060911182733.GR4181@aehallh.com>
X-Google-Sender-Auth: 1145a741c9a65c62
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Sun, Sep 10, 2006 at 06:19:31PM -0400, Dmitry Torokhov wrote:
> > >
> > > @@ -616,6 +617,15 @@ static int psmouse_extensions(struct psm
> > >   */
> > >                     max_proto = PSMOUSE_IMEX;
> > >             }
> > > +           ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
> >
> > Do we have to do 2nd reset here? Plus logic seems a bit fuzzy here -
> > if ALPS is detected but initizliztion fails it will start OLPC detection
> > which is probably not what you wanted...
>
> Reset is _probably_ not necessary, I'll verify.
>
> However the logic is the same as for all the others, if init succeeds,
> it returns PSMOUSE_ALPS, if it doesn't then it continues on to the next,
> which happens to be olpc, admittedly it would be more obvious that it's
> doing the same thing if it was in its own if, but.

Not exactly. We have 2 types of protocols - some have only detect,
others have both detect and init. For protocols that have both detect
and init we expect detect to reliably identify whether the device is
of given type or not and once detect succeeds we do not try to probe
for other speciality protocols. For example if alps_detect succeeds
but alps_init fails we won't try Genius detection (we will only try
standard imex, exps and bare) and we should not try OLPC detection
either.

-- 
Dmitry

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUI2H3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUI2H3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 03:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUI2H3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 03:29:36 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:2713 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268251AbUI2H3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 03:29:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 7/8] Psmouse - add packet size
Date: Wed, 29 Sep 2004 02:29:28 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290147.35864.dtor_core@ameritech.net> <20040929071504.GB2648@ucw.cz>
In-Reply-To: <20040929071504.GB2648@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290229.28652.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 02:15 am, Vojtech Pavlik wrote:
> On Wed, Sep 29, 2004 at 01:47:34AM -0500, Dmitry Torokhov wrote:
> 
> > -int alps_detect(struct psmouse *psmouse)
> > +int alps_detect(struct psmouse *psmouse, int set_properties)
> >  {
> > -	return alps_get_model(psmouse) < 0 ? 0 : 1;
> > +	if (alps_get_model(psmouse) < 0)
> > +		return 0;
> > +
> > +	if (set_properties) {
> > +		psmouse->vendor = "ALPS";
> > +		psmouse->name = "TouchPad";
> > +	}
> > +	return 1;
> >  }
> 
> I think we should return -1 (or -errno) on failure and 0 on success,
> like everybody else does.
>

All *detect functions return boolean value - either the device was detected or
not. I think it makes most sense. Negative error is convenient when function
normally returns some other meaningful value, like length. *detect is a simple
yes/no question, it is not really an error at all.
  
> 
> This should be:
> 
> 	if (param[0] != 3) 
> 		return -1;
> 	if (set_properties) {
> 		set_bit(REL_WHEEL, psmouse->dev.relbit);
> 		if (!psmouse->vendor) psmouse->vendor = "Generic";
> 		if (!psmouse->name) psmouse->name = "Wheel Mouse";
> 		psmouse->pktsize = 4;
> 	}
> 	return 0;
> 
> ... and similarly elsewhere. You save one level of nesting and it makes
> more sense.
> 

Ok, will change.

-- 
Dmitry

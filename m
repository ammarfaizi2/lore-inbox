Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWJBS7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWJBS7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWJBS7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:59:13 -0400
Received: from mail125.messagelabs.com ([85.158.136.35]:43586 "HELO
	mail125.messagelabs.com") by vger.kernel.org with SMTP
	id S964893AbWJBS7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:59:10 -0400
X-VirusChecked: Checked
X-Env-Sender: preece@urbana.css.mot.com
X-Msg-Ref: server-3.tower-125.messagelabs.com!1159815544!16141134!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [144.189.100.105]
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Mon, 2 Oct 2006 13:58:33 -0500 (CDT)
Message-Id: <200610021858.k92IwXJg011184@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: shd@zakalwe.fi
CC: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
In-reply-to: Heikki Orsila's message of Sun, 1 Oct 2006 18:22:28 +0300
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



| From: Heikki Orsila<shd@zakalwe.fi>
| 
| Some nitpicking about the patch follows..
| 
| On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
| > +static long 
| > +get_vtg(const char *vdomain)
| > +{
| > +	long ret = 0;
| 
| Unnecessary initialisation.
---

Many of us work in environments where initialization is in the coding
standard. It also helps with static analysis tools. CodingStyle seems to
be silent on the point, but points to Kernighan and Ritchie, who say
"These initializations are actually unnecessary, since all are zero, but
it's a good idea to make them explicit anyway."

Any reasonable compiler will avoid doing the initialization twice...

---
| ...
| > +static int cpu_vltg_show(void *md_opt, int *value)
| > +{
| > +	int rc = 0;
| > +	if (md_opt == NULL) {
| > +		if ((*value = get_vtg("v1")) <= 0)
| > +			return -EIO;
| > +	}
| > +	else {
| > +		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
| > +		*value = opt->cpu_vltg;
| > +	}
| > +
| > +	return rc;
| > +}
| 
| int rc is unnecessary because the function always returns 0. This 
| happens in many places.
---

Wonder if he wrote it for a coding standard that requires single return
(so that the "return -EIO" would have been "rc=-EIO") and converted
it...

scott

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWISTq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWISTq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWISTq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:46:27 -0400
Received: from ftpbox.mot.com ([129.188.136.9]:36012 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S1752004AbWISTq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:46:26 -0400
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Tue, 19 Sep 2006 14:46:19 -0500 (CDT)
Message-Id: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: pavel@ucw.cz
CC: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-reply-to: Pavel Machek's message of Tue, 19 Sep 2006 20:22:20 +0200
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



| From: Pavel Machek<pavel@ucw.cz>
| 
| > >>+struct powerop_driver {
| > >>+	char *name;
| > >>+	void *(*create_point) (const char *pwr_params, va_list args);
| > >>+	int (*set_point) (void *md_opt);
| > >>+	int (*get_point) (void *md_opt, const char *pwr_params, va_list 
| > >>args);
| > >>+};
| > >
| > >We can certainly get better interface than va_list, right?
| > 
| > Please elaborate.
| 
| va_list does not provide adequate type checking. I do not think it
| suitable in driver<->core interface.
---

Well, in this particular case the typing probably has to be weak, one
way or another. The meaning of the parameters is arguably opaque at
the interface - the attributes may be meaningful to specific components
of the system, but are not defined in the standardized interface (which
would otherwise have to know about all possible kinds of power
attributes and be changed every time a new one is added).

So, if you'd rather have an array of char* or void* values, that would
probably also meet the need, but my guess is that the typing is
intentionally opaque.

---
| ...
| > >How is it going to work on 8cpu box? will
| > >you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
| > 
| > i do not operate with term 'state' so I don't understand what it means here.
| 
| Okay, state here means "operating point". How will operating points
| look on 8cpu box? That's 256 states if cpus only support "low" and
| "high". How do you name them?
---

I don't think you would name the compounded states. Each CPU would need
to have its own defined set of operating points (since the capabilities
of the CPUs can reasonably be different).

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



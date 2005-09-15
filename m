Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVIOMDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVIOMDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVIOMDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:03:38 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:36304 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1750759AbVIOMDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:03:37 -0400
Message-ID: <432962B1.6040302@cs.aau.dk>
Date: Thu, 15 Sep 2005 14:01:53 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <Pine.LNX.4.61.0509151253120.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509151253120.3743@scrub.home>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Roman Zippel wrote:
> 
> The basic problem is that maintaining the bulk of autoconfig information 
> in a separate file is not feasible, it would be a nightmare to maintain.
> This means it would be better to integrate this information into Kconfig 
> and define interface so that external program/scripts (preferably shell 
> instead of perl) can use that to configure the kernel.
> 
> A simple example could look like this:
> 
> config FOO
> 	bool "foo"
> 	def_auto y

Why not directly having a direct reference to the name of the script ?

config FOO
	bool "foo"
	auto "detect-foo-script"

Where you have a specific directory in scripts/autoconfig/ where you
store the scripts. Each script output y, n or m.

But, it means a hell of scripts (except if we can pass arguments in the
auto field: auto "detect-foo-script card-XYZ release-32-or-higher").

This scheme seems much simpler to me (and yet not restrictive at all).
Of course, each script might have to ask few questions to the user as:
Do you want this FOO support ? [y/m/n]:

Or (when no module option):
Do you want this FOO support ? [y/n]:

When the feature is not detected or no field "auto" is found, the
feature is simply skipped silently.

I think this way is minimizing the foot print on the code and yet is
quite powerful. Moreover, you can add the auto-detection scripts without
interfering with the rest of the building system. The target autoconfig
will just be more and more efficient as long as more scripts are added.

Regards
-- 
Emmanuel Fleury

Assistant Professor          | Office: B1-201
Computer Science Department, | Phone:  +45 96 35 72 23
Aalborg University,          | Mobile: +45 26 22 98 03
Fredriks Bajersvej 7E,       | E-mail: fleury@cs.aau.dk
9220 Aalborg East, Denmark   | URL: www.cs.aau.dk/~fleury

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVAQXlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVAQXlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVAQXhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:37:12 -0500
Received: from opersys.com ([64.40.108.71]:58633 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261549AbVAQXd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:33:57 -0500
Message-ID: <41EC4D18.3060100@opersys.com>
Date: Mon, 17 Jan 2005 18:41:12 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>	 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>	 <41E7A7A6.3060502@opersys.com>	 <Pine.LNX.4.61.0501141626310.6118@scrub.home>	 <41E8358A.4030908@opersys.com>	 <Pine.LNX.4.61.0501150101010.30794@scrub.home>	 <41E899AC.3070705@opersys.com>	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>	 <41EA0307.6020807@opersys.com>	 <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com>	 <1105925842.13265.364.camel@tglx.tec.linutronix.de>	 <41EB21C2.3020608@opersys.com>	 <1105964417.13265.406.camel@tglx.tec.linutronix.de>	 <41EC20FB.9030506@opersys.com> <1106001113.13265.474.camel@tglx.tec.linutronix.de>
In-Reply-To: <1106001113.13265.474.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> I know, what I have said. I said reduce the filtering to the absolute
> minimum and do the rest in userspace.

You keep adopting the interpretation which best suits you, taking
quotes out of context, and keep repeating things that have already
been answered. There are limits to one's patience.

What you did is change your position twice. It's there for anyone to see.

> The now builtin filters are defined to fit somebodys needs or idea of
> what the user should / wants to see. They will not fit everybodys
> needs / ideas. So we start modifying, adding and #ifdefing kernel
> filters, which is a scary vision.

Ah, finally. Here's an actual suggestion. _IF_ you want, I'll just
export a ltt_set_filter(*callback) and rewrite the if in
_ltt_log_event() to:
if ((ltt_filter != NULL) && !(&ltt_filter(event_id, event_struct, data)))
	return -EINVAL;

You're always welcome to do the following from anywhere in your code:
ltt_set_filter(NULL);

> Enabling and disabling events is a valid basic filter request, which
> should live in the kernel. Anything else should go into userspace, IMO.

What you are suggesting is that a system administator that wants to
monitor his sendmail server over a period of three weeks should
just postprocess 1.8TB (1MB/s) of data because Thomas Gleixner didn't
like the idea of kernel event filtering based on anything but events.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

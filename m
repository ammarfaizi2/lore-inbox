Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVAaVRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVAaVRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVAaVQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:16:29 -0500
Received: from opersys.com ([64.40.108.71]:30220 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261369AbVAaVQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:16:15 -0500
Message-ID: <41FE9F57.5030603@opersys.com>
Date: Mon, 31 Jan 2005 16:12:55 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux, part 2
References: <16890.38062.477373.644205@tut.ibm.com>	<m1d5volksx.fsf@muc.de>	<16892.26990.319480.917561@tut.ibm.com>	<20050131125758.GA23172@muc.de>	<16894.23610.315929.805524@tut.ibm.com>	<41FE89E0.9030802@opersys.com> <16894.40247.701998.555392@tut.ibm.com>
In-Reply-To: <16894.40247.701998.555392@tut.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Zanussi wrote:
> I don't think they need to be mutually exclusive - we could keep
> relay_reserve(), but the relay_write() that's currently built on top
> of relay_reserve() would use the putc code instead.  It's complicating
> the API a bit, but if it makes everyone happy...

Actually I think that this would be a much better use of relay_write(),
which is unlikely to be used by any client that requires relay_reserve()
to start with. Also, I don't think it complicates the API at all.
Compared to the original API, what we've got now is very simple. So
it basically boils down to:
- use relay_write() if you want putc-like functionality.
- use relay_reserve() if you want to reserve space and write separately.

This is even better than having a separate ad-hoc mode.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

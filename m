Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVAQX45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVAQX45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVAQXxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:53:49 -0500
Received: from opersys.com ([64.40.108.71]:266 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262958AbVAQXuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:50:04 -0500
Message-ID: <41EC50E6.2080706@opersys.com>
Date: Mon, 17 Jan 2005 18:57:26 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
References: <20050114002352.5a038710.akpm@osdl.org>	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>	 <41E8543A.8050304@am.sony.com>	 <1105794499.13265.247.camel@tglx.tec.linutronix.de>	 <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home>	 <41E9EC5A.7070502@opersys.com>	 <1105919017.13265.275.camel@tglx.tec.linutronix.de>	 <41EB1AEC.3000106@opersys.com>	 <1105957604.13265.388.camel@tglx.tec.linutronix.de>	 <41EC2157.1070504@opersys.com> <1106000307.13265.462.camel@tglx.tec.linutronix.de>
In-Reply-To: <1106000307.13265.462.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> If we add another hardwired implementation then we do not have said
> benefits.

Please stop handwaving. Folks like Andrew, Christoph, Zwane, Roman,
and others actually made specific requests for changes in the code.
What makes you think you're so special that you think you are
entitled to stay on the side and handwave about concepts.

If there is a limitation with the code, please present actual
snippets that need to be changed and suggest alternatives. That's
what everyone else does on this list.

If you want to clean-up the existing tracing code in the kernel,
then here are some ltt calls you may be interested in:
int ltt_create_event(char *event_type,
		     char *event_desc,
		     int format_type,
		     char *format_data);
int ltt_log_raw_event(int event_id, int event_size, void *event_data);

And here's an actual example:
...
  delta_id = ltt_create_event("Delta",
                              NULL,
                              CUSTOM_EVENT_FORMAT_TYPE_HEX,
                              NULL);
...
  ltt_log_raw_event(delta_id, sizeof(a_delta_event), &a_delta_event);
...
  ltt_destroy_event(delta_id);

You can then use LibLTT to read the trace and extract your custom
events and format your binary data as it suits you.

Save the bandwidth and start cleaning.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

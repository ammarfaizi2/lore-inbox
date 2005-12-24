Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161162AbVLXD2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbVLXD2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 22:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbVLXD2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 22:28:18 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:27218 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161162AbVLXD2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 22:28:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: kernel/auditsc.c bug
Date: Fri, 23 Dec 2005 22:28:14 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Rickard E. (Rik) Faith" <faith@redhat.com>
References: <1135394240.22177.94.camel@mindpipe>
In-Reply-To: <1135394240.22177.94.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512232228.14465.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 December 2005 22:17, Lee Revell wrote:
> gcc 4.0.2 complains that state is (not "may be", is) used initialized on
> line 607:
> 
> 605         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_USER], list) {
> 606                 if (audit_filter_user_rules(cb, &e->rule, &state)) {
> 607                         if (state == AUDIT_DISABLED)
> 608                                 ret = 0;
> 609                         break;
> 610                 }
> 
> AFAICT state will always have been initialized if
> audit_filter_user_rules() returns nonzero:
> 
> 590         switch (rule->action) {
> 591         case AUDIT_NEVER:    *state = AUDIT_DISABLED;       break;
> 592         case AUDIT_POSSIBLE: *state = AUDIT_BUILD_CONTEXT;  break;
> 593         case AUDIT_ALWAYS:   *state = AUDIT_RECORD_CONTEXT; break;
> 594         }
> 595         return 1;
> 
> Is GCC correct that this is a bug (no default case in the switch
> statement)?
>

Well, rule actions are #defines, how can a compiler know that the switch
covers all possible values? If they were enums OTOH...

-- 
Dmitry

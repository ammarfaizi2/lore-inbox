Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbVLXDMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbVLXDMr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 22:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030614AbVLXDMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 22:12:47 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:25796 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030611AbVLXDMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 22:12:46 -0500
Subject: kernel/auditsc.c bug
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Rickard E. (Rik) Faith" <faith@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 22:17:19 -0500
Message-Id: <1135394240.22177.94.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 4.0.2 complains that state is (not "may be", is) used initialized on
line 607:

605         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_USER], list) {
606                 if (audit_filter_user_rules(cb, &e->rule, &state)) {
607                         if (state == AUDIT_DISABLED)
608                                 ret = 0;
609                         break;
610                 }

AFAICT state will always have been initialized if
audit_filter_user_rules() returns nonzero:

590         switch (rule->action) {
591         case AUDIT_NEVER:    *state = AUDIT_DISABLED;       break;
592         case AUDIT_POSSIBLE: *state = AUDIT_BUILD_CONTEXT;  break;
593         case AUDIT_ALWAYS:   *state = AUDIT_RECORD_CONTEXT; break;
594         }
595         return 1;

Is GCC correct that this is a bug (no default case in the switch
statement)?

Lee


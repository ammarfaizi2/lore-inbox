Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVJOVjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVJOVjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 17:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVJOVjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 17:39:51 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:26849 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S1751223AbVJOVjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 17:39:51 -0400
Date: Sat, 15 Oct 2005 23:39:53 +0200
To: linux-kernel@vger.kernel.org
Subject: force feedback envelope incomplete
Message-ID: <20051015213953.GA27117@tink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: emard@softhome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

Force feedback envelope struct in input.h 
for periodic events is incomplete.

struct ff_envelope {
        __u16 attack_length;    /* Duration of attack (ms) */
        __u16 attack_level;     /* Level at beginning of attack */
        __u16 fade_length;      /* Duration of fade (ms) */
        __u16 fade_level;       /* Level at end of fade */
};

The envelope consists of:
1. Attack level (Level at beginning of attack)
2. Attack time
3. Sustain level (Level at end of attack and beginning of fade)
4. Sustain time
5. Fade level (Level at the end of fade)
6. Fade time

If I want to implement proper envelope I propose something like this:

struct ff_envelope {
        __u16 attack_length;    /* Duration of attack (ms) */
        __u16 attack_level;     /* Level at beginning of attack */
        __u16 sustain_length;   /* Duration of sustain (ms) */
        __u16 sustain_level;    /* Sustain Level at end of attack and beginning of fade */
        __u16 fade_length;      /* Duration of fade (ms) */
        __u16 fade_level;       /* Level at end of fade */
};

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTEAWK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTEAWK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:10:28 -0400
Received: from main.gmane.org ([80.91.224.249]:36484 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262710AbTEAWK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:10:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh a PS/2 Trackpad
Date: 02 May 2003 00:13:53 +0200
Message-ID: <yw1x4r4eqpr2.fsf@zaphod.guide>
References: <3EB19625.6040904@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Georg Thien <1682-600@onlinehome.de> writes:

>  static inline void handle_keyboard_event(unsigned char scancode)
>  {
> +
> +#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
> +
> +        /* setup a timer to re-enable the trackpad */
> +        static struct timer_list enable_trackpad_timer;
> +        static int enable_trackpad_timer_initialized=0;
> +
> +        disable_trackpad_while_typing=1; /* disable trackpad */
> +
> +        if(enable_trackpad_timer_initialized)
> +        {
> +                 /* trackpad timer already exists, - just restart it */
> +                 mod_timer(&enable_trackpad_timer, jiffies+trackpad_delay);
> +        }
> +        else
> +        {
> +                 /* no trackpad timer yet. Initialize and start it */
> +                 init_timer(&enable_trackpad_timer);
> +                 enable_trackpad_timer.expires=jiffies+trackpad_delay;
> +                 enable_trackpad_timer.function=enable_trackpad;
> +                 add_timer(&enable_trackpad_timer);
> +                 enable_trackpad_timer_initialized=1;

The else block would probably be better off in some initialization
function.  Maybe the same place that sets up the interrupt handler is
appropriate.

-- 
Måns Rullgård
mru@users.sf.net


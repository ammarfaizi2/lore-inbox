Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424439AbWLBUBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424439AbWLBUBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 15:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424444AbWLBUBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 15:01:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:45265 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1424439AbWLBUBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 15:01:24 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org, maynardj@us.ibm.com
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
Date: Sat, 2 Dec 2006 21:00:19 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <45708A0B.6000106@us.ibm.com>
In-Reply-To: <45708A0B.6000106@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612022100.20609.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 December 2006 21:01, Maynard Johnson wrote:
> +static void notify_spus_active(void)
> +{
> +       int node;
> +       for (node = 0; node < MAX_NUMNODES; node++) {
> +               struct spu *spu;
> +               mutex_lock(&spu_prio->active_mutex[node]);
> +               list_for_each_entry(spu, &spu_prio->active_list[node], list) {
> +                                struct spu_context *ctx = spu->ctx;
> +                                blocking_notifier_call_chain(&spu_switch_notifier,
> +                                                ctx ? ctx->object_id : 0, spu);
> +               }
> +               mutex_unlock(&spu_prio->active_mutex[node]);
> +        }

I wonder if this is enough for oprofile. Don't you need to access user
space data of the task running on the SPU? I always assumed you want
to do it via get_user or copy_from_user, which obviously doesn't work
here, when you're running in the oprofile task. Are you using something
like access_process_vm now?

	Arnd <><

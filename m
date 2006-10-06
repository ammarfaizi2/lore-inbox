Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422954AbWJFUyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422954AbWJFUyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422953AbWJFUyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:54:38 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:31943 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1422954AbWJFUyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:54:36 -0400
Date: Fri, 6 Oct 2006 22:54:35 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Subject: softirq.c: tasklet_action() question
Message-ID: <20061006205435.GA19190@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

ok, possibly stupid question, but what the heck is THAT?:


static void tasklet_action(struct softirq_action *a)
{
        struct tasklet_struct *list;

        local_irq_disable();
        list = __get_cpu_var(tasklet_vec).list;
        __get_cpu_var(tasklet_vec).list = NULL;
        local_irq_enable();

	while (list) {


(same in tasklet_hi_action())

My gut reaction to this would be something similar to:

static void tasklet_action(struct softirq_action *a)
{
        struct tasklet_struct *list = NULL;

	super_cool_n_fast_atomic_xchg(&__get_cpu_var(tasklet_vec).list, &list);

	while (list) {
	

I'm sure it's obviously not quite as simple as that (maybe requires
atomic xchg extension of the cpu var API?), but would something like that be
possible (at least optionally or for non-SMP?) to avoid the IRQ masking
latency penalty, especially on x86?
(still hacking on a measly P3/700, and am bloody determined to keep it
that way for a looong time ;)

I'm sure that I'm missing something, so what is it? ;)

Andreas Mohr

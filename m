Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWHPMgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWHPMgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWHPMgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:36:04 -0400
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:22159 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1751156AbWHPMgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:36:03 -0400
Message-ID: <44E3118A.20402@kolumbus.fi>
Date: Wed, 16 Aug 2006 15:37:30 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [take10 1/2] kevent: Core files.
References: <11557316932803@2ka.mipt.ru>
In-Reply-To: <11557316932803@2ka.mipt.ru>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2 HF462|May 23, 2006) at 16.08.2006 15:35:59,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 16.08.2006 15:35:59,
	Serialize complete at 16.08.2006 15:35:59,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 16.08.2006 15:35:59,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 16.08.2006 15:36:02,
	Serialize complete at 16.08.2006 15:36:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+void kevent_user_ring_add_event(struct kevent *k)
+{
+	unsigned int pidx, off;
+	struct kevent_mring *ring, *copy_ring;
+
+	ring = (struct kevent_mring *)k->user->pring[0];
+	
+	pidx = ring->index/KEVENTS_ON_PAGE;
+	off = ring->index%KEVENTS_ON_PAGE;
+
+	copy_ring = (struct kevent_mring *)k->user->pring[pidx];
+
+	copy_ring->event[off].id.raw[0] = k->event.id.raw[0];
+	copy_ring->event[off].id.raw[1] = k->event.id.raw[1];
+	copy_ring->event[off].ret_flags = k->event.ret_flags;
+
+	if (++ring->index >= KEVENT_MAX_EVENTS)
+		ring->index = 0;
+}

Can you assume that the page at pidx is already allocated and why?

--Mika



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVCOJWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVCOJWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 04:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVCOJWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 04:22:38 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:34176 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262354AbVCOJWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 04:22:36 -0500
Message-ID: <4236B8B2.AD69714@tv-sign.ru>
Date: Tue, 15 Mar 2005 13:28:02 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Shai Fultheim <Shai@Scalex86.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] del_timer_sync scalability patch
References: <4231E959.141F7D85@tv-sign.ru> <42343C61.6A1210C0@tv-sign.ru> <Pine.LNX.4.58.0503150004190.13281@server.graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>
> @@ -476,6 +454,7 @@ repeat:
>  				}
>  			}
>  			spin_lock_irq(&base->lock);
> +			timer->running = 0;
			^^^^^^^^^^^^^^^^^^
>  			goto repeat;
>  		}
>  	}

This is imho wrong. The timer probably don't exist when
timer_list->function returns.

I mean, timer_list->function could deallocate timer's memory.

Oleg.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVKCDYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVKCDYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbVKCDYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:24:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030287AbVKCDYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:24:34 -0500
Date: Thu, 3 Nov 2005 13:24:12 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 01/37] dvb: dst: Correcty Identify Tuner and
 Daughterboards
Message-Id: <20051103132412.6266ccf0.akpm@osdl.org>
In-Reply-To: <4367235B.40608@m1k.net>
References: <4367235B.40608@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
>  +static int dst_get_tuner_info(struct dst_state *state)
>  +{
>  +	u8 get_tuner_1[] = { 0x00, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
>  +	u8 get_tuner_2[] = { 0x00, 0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
>  +
>  +	get_tuner_1[7] = dst_check_sum(get_tuner_1, 7);
>  +	get_tuner_2[7] = dst_check_sum(get_tuner_2, 7);
>  +	if (state->type_flags & DST_TYPE_HAS_MULTI_FE) {
>  +		if (dst_command(state, get_tuner_2, 8) < 0) {
>  +			dprintk(verbose, DST_INFO, 1, "Unsupported Command");
>  +			return -1;
>  +		}
>  +	} else {
>  +		if (dst_command(state, get_tuner_1, 8) < 0) {
>  +			dprintk(verbose, DST_INFO, 1, "Unsupported Command");
>  +			return -1;
>  +		}
>  +	}
>  +	memset(&state->board_info, '\0', 8);
>  +	memcpy(&state->board_info, &state->rxbuffer, 8);

The memset is unneeded...

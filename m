Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276075AbRJBSFK>; Tue, 2 Oct 2001 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276079AbRJBSFA>; Tue, 2 Oct 2001 14:05:00 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49050 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276075AbRJBSEn>; Tue, 2 Oct 2001 14:04:43 -0400
Subject: sys_personality changes
From: Paul Larson <plars@austin.ibm.com>
To: hch@caldera.de
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 02 Oct 2001 13:10:54 +0000
Message-Id: <1002028258.8601.55.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm curious about the purpose of the sys_personality changes that made
it into 2.4.10.  In 2.4.9, it looked like this:

asmlinkage long sys_personality(unsigned long personality)
{
        int ret = current->personality;
        if (personality != 0xffffffff) {
                set_personality(personality);
                if (current->personality != personality)
                        ret = -EINVAL;
        }
        return ret;
}

Compared to your new one:

asmlinkage long
sys_personality(u_long personality)
{
        if (personality == 0xffffffff)
                goto ret;
        set_personality(personality);
        if (current->personality != personality)
                return -EINVAL;
ret:
        return (current->personality);
}

What was the purpose of changing the way sys_personality works?  AFAIK
sys_personality is supposed to return the previous persona.  Yours
returns the new persona instead.

Was this intended, or can we roll back this part of your patch?

Thanks,
Paul Larson


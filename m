Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSJYBdq>; Thu, 24 Oct 2002 21:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261287AbSJYBdq>; Thu, 24 Oct 2002 21:33:46 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:17412 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261258AbSJYBdp>; Thu, 24 Oct 2002 21:33:45 -0400
Date: Fri, 25 Oct 2002 02:39:52 +0100
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 6 - "Well I thought the last one was ready"
Message-ID: <20021025013952.GA34678@compsoc.man.ac.uk>
References: <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk> <3DB85213.4020509@mvista.com> <20021024202910.GA16192@compsoc.man.ac.uk> <3DB89CD9.5090409@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB89CD9.5090409@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *184tS4-000EP7-00*cLqWeiovVvM* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 08:22:33PM -0500, Corey Minyard wrote:

> http://home.attbi.com/~minyard/linux-nmi-v6.diff.

                case NOTIFY_DONE:
                default:
                }

This needs to be :

		case NOTIFY_DONE:
		default:;
		}

or later gcc's whine.

+ * handler, if you have a fast-path handler there's another tie-in
+ * for you.  See the oprofile code.

You forgot to remove this comment.

        if (!list_empty(&(handler->link)))
                return EBUSY;

This wants to be -EBUSY (it eventually gets returned to userspace via
oprofile, and is more common anyway).

static int nmi_std (void           * dev_id,
                    struct pt_regs * regs,
                    int            cpu,
                    int            handled)

I don't think this matches the usual kernel style.

I think the rest looks OK, I'll find some time to play with oprofile
side of this.

thanks
john

-- 
"This is playing, not work, therefore it's not a waste of time."
	- Zath

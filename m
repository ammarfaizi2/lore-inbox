Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUAKQcp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUAKQcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:32:45 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:27922 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265346AbUAKQcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:32:43 -0500
Date: Sun, 11 Jan 2004 17:32:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: sven kissner <sven.kissner@consistencies.net>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Message-ID: <20040111163239.GA1955@win.tue.nl>
References: <UTC200401111358.i0BDwIM08113.aeb@smtp.cwi.nl> <200401111705.30788.sven.kissner@consistencies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401111705.30788.sven.kissner@consistencies.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 05:05:06PM +0100, sven kissner wrote:

> sure but it's not working:

> # setkeycodes 91 120
> setkeycode: code outside bounds

Hm, yes. What about this version?

-------- sk.c -------
/*
 * call: sk scancode keycode
 *  (where scancode is given in hexadecimal, and keycode in decimal)
 */
#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <linux/kd.h>

int
main(int argc, char **argv) {
        struct kbkeycode a;
        char *ep;

        if (argc != 3) {
                fprintf(stderr, "Call: sk scancode keycode\n");
                exit(1);
        }

        a.scancode = strtol(argv[1], &ep, 16);
        a.keycode = atoi(argv[2]);

        if (ioctl(0, KDSETKEYCODE, &a)) {
                perror("KDSETKEYCODE");
                fprintf(stderr, "failed to set scancode 0x%x to keycode %d\n",
                        a.scancode, a.keycode);
                exit(1);
        }

        return 0;
}


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbUL0VkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUL0VkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUL0VkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:40:23 -0500
Received: from holomorphy.com ([207.189.100.168]:63443 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261990AbUL0VkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:40:19 -0500
Date: Mon, 27 Dec 2004 13:40:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Oops on 2.4.x invalid procfs i_ino value
Message-ID: <20041227214013.GG771@holomorphy.com>
References: <Pine.SGI.4.61.0412171611120.27132@kzerza.americas.sgi.com> <20041218003835.GD771@holomorphy.com> <20041218004703.GE771@holomorphy.com> <Pine.SGI.4.61.0412201624340.46534@kzerza.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.61.0412201624340.46534@kzerza.americas.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004, William Lee Irwin III wrote:
>> Ouch, 2.4.21; this will be trouble. So next, what patches atop 2.4.21?

On Mon, Dec 20, 2004 at 04:35:18PM -0600, Brent Casavant wrote:
> I wouldn't worry about the pid=0 issue -- I think it's most likely
> due to the PAGG patches (http://oss.sgi.com/projects/pagg) causing
> some sort of problem at process teardown (all the pid=0 processes are
> in the process of exiting).
> I'm more concerned about the (0 == pid & 0xffff) bug, which is present
> in the unpatched mainline 2.4.x kernel.  It seems that the easiest fix
> is marking such pids as in-use at pidmap allocation, so that they are
> never assigned to real tasks.  I've got the code almost done, but need
> to port it to top-of-tree before submitting a patch.

I see no 0 == pid & 0xffff nor any pidmap in unpatched 2.4.x. Also,
please notice that pid & ~(PID_MAX-1) a.k.a. pid & ~0x7fff a.k.a.
pid & 0xffff8000? And so it appears numerous checks of this form are
already there.

Perhaps the pristine sources are not as pristine as one had hoped?


-- wli

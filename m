Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTJTDdM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 23:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTJTDdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 23:33:12 -0400
Received: from holomorphy.com ([66.224.33.161]:46212 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262395AbTJTDdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 23:33:11 -0400
Date: Sun, 19 Oct 2003 20:33:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pedro Larroy <piotr@member.fsf.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] D-states in test8
Message-ID: <20031020033306.GF1215@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pedro Larroy <piotr@member.fsf.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031019205630.GA1153@81.38.200.176> <20031019160127.191a189a.akpm@osdl.org> <20031020012914.GA1315@81.38.200.176> <20031019183610.4410757b.akpm@osdl.org> <20031020022443.GA1723@81.38.200.176>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020022443.GA1723@81.38.200.176>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 06:36:10PM -0700, Andrew Morton wrote:
>> Well.  The emphasis is on "might".  That locking bug was on an error path
>> and it's quite possible that the deadlock is due to a different bug which
>> is still there.

On Mon, Oct 20, 2003 at 04:24:43AM +0200, Pedro Larroy wrote:
> Now seems I can't get them stuck.
> Hmm, Before I just opened twice /dev/dsp IIRC and then both processes got 
> stuck in D.
> so snd_pcm_open_file must have returned < 0
> I can try to play a little with it tomorrow to see why gets into the error 
> path.

O_NONBLOCK usage when snd_pcm_open_file() returns -EAGAIN (e.g.
SUBSTREAM_BUSY() is true, i.e. substream->file != NULL) is a trivial
way to get into the error path.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269716AbUINTlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269716AbUINTlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUINTjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:39:13 -0400
Received: from holomorphy.com ([207.189.100.168]:3990 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269747AbUINTgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:36:37 -0400
Date: Tue, 14 Sep 2004 12:36:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914193626.GG9106@holomorphy.com>
References: <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com> <20040914184517.GA2655@k3.hellgate.ch> <20040914190747.GA9106@holomorphy.com> <20040914193139.GA30827@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914193139.GA30827@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 12:07:47 -0700, William Lee Irwin III wrote:
>> Okay, so what kinds of errors are returned in this case, if any, or
>> (worst case) are the offending tasks completely silently dropped?

On Tue, Sep 14, 2004 at 09:31:39PM +0200, Roger Luethi wrote:
> In published code: No access control whatsoever. In dev tree: Silently
> dropped. Possible: Any kind of error and additional information that
> makes sense (we have netlink messages as a transport, after all).

I'm not sure what to make of this.


On Tue, Sep 14, 2004 at 09:31:39PM +0200, Roger Luethi wrote:
> That said, I don't think dropping tasks silently is a "worst case"
> in this scenario. Whatever your error report is going to be, it will
> boil down to saying "some tasks that may or may not live by the time
> you read this have been skipped because some fields that you knew had
> access restrictions prevented providing the information in those cases,
> and I must be cautious about not revealing any sensitive information
> to you so sorry I can't be more helpful". What's a tool going to do
> with that? If it cares to get a complete snapshot, it can simply send
> two requests: One with and one without restricted fields.
> So the tool would, say, request PID/VmSize in the first message and
> environ in the second message. Since only the owner can read the
> environment, the second request would yield answers only for a subset
> of the total process table.

This sounds safe enough, though it's unclear how to predict what fields
may be restricted. I suppose one doesn't try and requests one field at
a time for all tasks in this model of interaction with userspace.


-- wli

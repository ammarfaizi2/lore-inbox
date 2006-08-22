Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWHVQ1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWHVQ1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWHVQ1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:27:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:56362 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751410AbWHVQ1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:27:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WetxDtARekLBTk+UXNRZWaitLYnn2gJgdQxnlLKM0XZYNT7jom/iazq12ARlDRP4Uy/Sr4L2z4CPoSfL6MzckPZw4RiogirEOfzVRA9WUu2j0Fn6foQyekCJSKrhf+jtob9mjGMXht3ep6M+jvqmJnAjR24SMXVZS0KPC54lEvo=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: mplayer + heavy io: why ionice doesn't help?
Date: Tue, 22 Aug 2006 18:26:08 +0200
User-Agent: KMail/1.8.2
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, mplayer-users@mplayerhq.hu,
       linux-kernel@vger.kernel.org
References: <200608181937.25295.vda.linux@googlemail.com> <200608201843.58849.vda.linux@googlemail.com> <1156109768.10565.55.camel@mindpipe>
In-Reply-To: <1156109768.10565.55.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221826.08802.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I eliminated skips due to CPU and disk using
> > nice and -cache 8000. I still can make it skip
> > when my KDE background picture is changing.
> > 
> 
> I also must run mplayer at nice -20 for it to be usable.
> 
> > I think that these skips are caused by the X server.
> > It has no prioritization for request handling and
> > thus it does not paint mplayer output fast enough:
> > it needs to repaint background and semi-transparent
> > konsole(s), and that is taking a few seconds at least.
> > 
> > This is probably aggravated by serializing nature of Xlib,
> > according to:
> > 
> > http://en.wikipedia.org/wiki/XLib
> > http://en.wikipedia.org/wiki/XCB
> 
> I think the problem is also due to mplayer's faulty design.  It should
> be multithreaded and use RT threads for the time sensitive work, like
> all professional AV applications and many other consumer players do.

RT - yes, multithreaded - unsure. Witness how squid manages to
serve hundreds of simultaneous streams using just a single process.

Multithreading seems cool on the first glance and it is easier to code
than clever O_NONBLOCK/select/poll/etc stuff. However,
on single-CPU boxes, which are still a majority, multithreading
just incurs context switching penalty. It cannot magically
make CPU do more work in a unit of time.
--
vda

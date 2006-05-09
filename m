Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWEIEgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWEIEgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 00:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWEIEgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 00:36:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61374 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751375AbWEIEgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 00:36:48 -0400
Subject: Re: High load average on disk I/O on 2.6.17-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
In-Reply-To: <445FF714.4050803@yahoo.com.au>
References: <200605051010.19725.jasons@pioneer-pra.com>
	 <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org>
	 <1147100149.2888.37.camel@laptopd505.fenrus.org>
	 <20060508152255.GF1875@harddisk-recovery.com>
	 <1147102290.2888.41.camel@laptopd505.fenrus.org>
	 <445FF714.4050803@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 09 May 2006 06:36:39 +0200
Message-Id: <1147149399.3198.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 11:57 +1000, Nick Piggin wrote:
> Arjan van de Ven wrote:
> 
> >>... except that any kernel < 2.6 didn't account tasks waiting for disk
> >>IO.
> >>
> >
> >they did. It was "D" state, which counted into load average.
> >
> 
> Perhaps kernel threads in D state should not contribute toward load avg

that would be a change from, well... a LONG time

The question is what "load" means; if you want to change that... then
there are even better metrics possible. Like
"number of processes wanting to run + number of busy spindles + number
of busy nics + number of VM zones that are below the problem
watermark" (where "busy" means "queue full")

or 50 million other definitions. If we're going to change the meaning,
we might as well give it a "real" meaning. 

(And even then it is NOT a good measure for determining if the machine
can perform more work, the graph I put in a previous mail is very real,
and in practice it seems the saturation line is easily 4x or 5x of the
"linear" point)


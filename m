Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbUJ0K3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbUJ0K3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUJ0K0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:26:17 -0400
Received: from serena.fsr.ku.dk ([130.225.215.194]:16829 "EHLO
	serena.fsr.ku.dk") by vger.kernel.org with ESMTP id S262380AbUJ0KVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:21:09 -0400
To: linux-kernel@vger.kernel.org
Subject: /proc/net/tcp not updated fast enough?
From: Henrik Christian Grove <grove@fsr.ku.dk>
Organization: Forenede =?iso-8859-1?q?Studenterr=E5d?= ved
  =?iso-8859-1?q?K=F8benhavns?= Universitet
Date: 27 Oct 2004 12:21:07 +0200
Message-ID: <7gekjkpilo.fsf@serena.fsr.ku.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I'm writing a SMTP proxy that needs to know the uid of the user
connecting (only connections from the same machine is supposed to work).

I find the uid by searching /proc/net/tcp, for a line having a
0100007F:<port I get from accept on the socket I listen on> as
local_address and <any-ip>:<the port I listen on> as rem_address, and
that works perfectly -- most of the time.

I have it running on 11[1] machines and since midnight (it's 11:47 here
now) I have 2397 succesfull connections, but in 31 cases (that's 1,29%
of the connections - and thus not totally ignorable) I had to read
through /proc/net/tcp twice to find the uid. Does that sound plausible,
or more like I'm doing something wrong?

If it's plausible, how long can it take for /proc/net/tcp to get the
info? I'm asking because I see one connection (again since midnight)
where I don't find any uid in the 5 attempts I do as a max.

If it's plausible could it explain why I have 9 connections apparently
coming from root, although they seem to come from a program _not_
running as root? Here "seem" means that I have tried logging the
(relevant parts of the) output from `netstat -tnp` when I got these
connections and the pid was the pid of a program I've written myself,
that would complain in the log if it were running as root.
(There's also a single connection from uid 33 (that's a uid apache runs
as) and one from uid 99 (unused), but they are so rare I haven't tried
tracing them yet).

It wasn't until yesterday that I started suspecting /proc/net/tcp from
"lagging", so I don't have reliable numbers from yesterday.

The machines run a 2.4.25 kernel with vserver-patches (the proxy
actually runs in a vserver).

.Henrik

[1] Actually one of them has only been running since around 4:45 this
morning, but that shouldn't matter.

-- 
"Det er fundamentalt noget humanistisk vås, at der er noget, 
 der hedder blød matematik."
   --- citat Henrik Jeppesen, dekan for det naturvidenskabelige fakultet

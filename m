Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbTDGIYY (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTDGIYY (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:24:24 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59149 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263333AbTDGIYW (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:24:22 -0400
Date: Mon, 7 Apr 2003 04:35:56 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030407043555.G13397@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <b6qruf$elf$1@cesium.transmeta.com> <b6r9cv$jof$1@news.cistron.nl> <20030407081800.GA48052@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030407081800.GA48052@dspnet.fr.eu.org>; from galibert@pobox.com on Mon, Apr 07, 2003 at 10:18:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 10:18:00AM +0200, Olivier Galibert wrote:
> On Mon, Apr 07, 2003 at 07:29:35AM +0000, Miquel van Smoorenburg wrote:
> > Can't you just check those permissions, i.e. behave like link() ?
> > If you cant't access the path to the file, don't permit flink() ?
> 
> Which path ?  A file can have many paths to it, or to the other
> extreme none at all.

There is at most one path associated with an opened file - d_path on
file->f_dentry. If a fd has no path, don't permit flink().
Alternatively, flink() could have 3 arguments, 2 like link and an opened
fd, which would atomically do if fd describes the same object as buf,
link buf to newname.

	Jakub

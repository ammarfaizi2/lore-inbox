Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263898AbUFBTpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUFBTpZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUFBTpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:45:25 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:9345
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263898AbUFBTpX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:45:23 -0400
Subject: Re: NFS client behavior on close
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040602191603.GC4962@netnation.com>
References: <20040531213820.GA32572@netnation.com>
	 <1086159327.10317.2.camel@lade.trondhjem.org>
	 <20040602154146.GA2481@netnation.com>
	 <1086194307.17378.106.camel@lade.trondhjem.org>
	 <20040602191603.GC4962@netnation.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086205521.4463.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Jun 2004 12:45:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 02/06/2004 klokka 12:16, skreiv Simon Kirby:

> Ok, that makes sense -- if NFSv2 has no fsync(), then using "async" mode
> definitely sounds broken.  But is this the same with NFSv3?

The problem is that Linux's "async" implementation short-circuits the
NFSv3 fsync() equivalent. Not good!


> NFS should just extend fsync() back to the server -- with minimal caching
> on the client, normal write-back caching on the server, and where fsync()
> on the client forces the server to write before returning on the client. 
> Forcing this to happen on close() doesn't even line up with local file
> systems.

That still leaves room for races with other clients trying to open the
file after the server comes up after a crash, then finding stale data.
(Free|Net|Open)BSD choose to ignore that race, and do the above. I'm not
aware of anybody else doing so, though...

Performance is good, but it should always take second place to data
integrity. There are more than enough people out there who are
entrusting research projects, banking data,... to their NFS server.

Cheers,
  Trond

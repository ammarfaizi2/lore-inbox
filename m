Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281478AbRK0Q4x>; Tue, 27 Nov 2001 11:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRK0Q4l>; Tue, 27 Nov 2001 11:56:41 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:4358 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281478AbRK0Q4c>; Tue, 27 Nov 2001 11:56:32 -0500
Date: Tue, 27 Nov 2001 17:56:29 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011127175629.E13416@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain> <20011126165920.N730@lynx.no> <9tumf0$dvr$1@cesium.transmeta.com> <9tuo54$e8p$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9tuo54$e8p$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, H. Peter Anvin wrote:

> On the subject of write barriers... such a setup probably should have
> a serial number field for each write barrier command, and a "WAIT FOR
> WRITE BARRIER NUMBER #" command -- which will wait until all writes
> preceeding the specified write barrier has been committed to stable
> storage.  It might also be worthwhile to have the equivalent
> nonblocking operation -- QUERY LAST WRITE BARRIER COMMITTED.

A query model is not useful, because it involves polling, which is not
what you want because it clogs up the CPU.

Write barriers may be fun, however, they impose ordering constraints on
the host side, which is not too useful. Real tagged commands and tagged
completion will be really useful for performance, with write barriers,
for example:

data000 group A
data001 group B
data254 group A
data253 group A
data274 group B
barrier group A
data002 group B

or something, and the drive could reorder anything, but it would only
have to guarantee that all group-A data sent before the barrier would
have made it to disk when the barrier command completed.

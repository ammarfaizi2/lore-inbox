Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132644AbRDOMw0>; Sun, 15 Apr 2001 08:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbRDOMwQ>; Sun, 15 Apr 2001 08:52:16 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:62984 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132644AbRDOMwD>; Sun, 15 Apr 2001 08:52:03 -0400
Date: 15 Apr 2001 11:07:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
cc: kbuild-devel@lists.sourceforge.net
Message-ID: <7zuzLtMHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0103261153510.1863-100000@imladris.rielhome.conectiva>
Subject: Re: [kbuild-devel] Re: CML1 cleanup patch
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E14hVd6-0007eK-00@mercury.ccil.org> <Pine.LNX.4.21.0103261153510.1863-100000@imladris.rielhome.conectiva>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning: No kernel related stuff inside.

riel@conectiva.com.br (Rik van Riel)  wrote on 26.03.01 in <Pine.LNX.4.21.0103261153510.1863-100000@imladris.rielhome.conectiva>:

> On Mon, 26 Mar 2001, John Cowan wrote:

> > In fact this has come up before: in Usenet software, which has to
> > differentiate between an article and a sub-newsgroup.  An article has
> > to have an all-numeric name, and It Would Have Been Nice if all
> > newsgroup names began with non-digits, but then there was
> > comp.bugs.4bsd.
>
> What's wrong with using the _file type_ for these things ?

Wrong problem description, really. The problem is not components starting  
with digits, the problem is all-numeric components as in alt.2600.

And the problem is that this hits a fast path in the classical news spool  
layout article create path. The code for this assumes that you have  
articles in the range X to Y, and you just got a new article, so you write  
a file called /var/spool/news/group/name/Y+1. You really do not want to  
cope with the possibility of a directory Y+1 existing in that place.

I think there are some other things that also get impacted on their fast  
path, but this is probably the most important.

And then, it's an ugly user interface: the classical spool layout does  
assume that you look at that scpool with Unix tools (like find and grep),  
not only via NNTP and the server.

MfG Kai

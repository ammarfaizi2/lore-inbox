Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTLMPBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 10:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265143AbTLMPBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 10:01:21 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:35855 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S265100AbTLMPBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 10:01:19 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <3FCDE5CA.2543.3E4EE6AA@localhost>
	<Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
	<Pine.LNX.4.58.0312031614000.2055@home.osdl.org>
	<20031204192452.GC10421@parcelfarce.linux.theplanet.co.uk>
	<877k11y3sh.fsf@amaterasu.srvr.nix>
	<20031213002530.GL4176@parcelfarce.linux.theplanet.co.uk>
From: Nix <nix@esperi.org.uk>
X-Emacs: the Swiss Army of Editors.
Date: Sat, 13 Dec 2003 15:01:14 +0000
In-Reply-To: <20031213002530.GL4176@parcelfarce.linux.theplanet.co.uk> (viro@parcelfarce.linux.theplanet.co.uk's
 message of "Sat, 13 Dec 2003 00:25:30 +0000")
Message-ID: <87vfokwymd.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Dec 2003, viro@parcelfarce.linux.theplanet.co.uk yowled:
> On Sat, Dec 13, 2003 at 12:11:58AM +0000, Nix wrote:
>> > 	Some approximation might be obtained by building all modules and
>> > doing nm on them, with manual work for non-obvious cases.
>> 
>> Hang on, surely you can tell which symbols in modules are exported just
>> by looking for expansions of EXPORT_SYMBOL{_GPL}? Why is this bit hard?
> 
> It's not a question of which symbols are exported by module, it's what
> symbols are _imported_.

Yes, of course. That's what you use the hacked-up non-macro-expanding-or-
#if-processing preprocessor for. :)

> IOW, the hard question is "what modules use foo()", not "where do we define
> foo()".  And while it's easy for a single symbol, we want it for _all_
> exported symbols in the tree at once.

Hm, OK, so a hacked cpp isn't good enough because it still requires more
than grep over preprocessed-save-for-#if-and-macro-expansion sources to
determine if you'll get an external symbol reference.

(Hm, or does it? We'll get FPs doing it that way, from text in literal
strings, but how many? How many modules contain the names of exported
symbols from other modules in literal strings? Not many, I guess, but
there's no way to tell but to try... I'll have a whack at it.)

-- 
`...some suburbanite DSL customer who thinks kernel patches are some
 form of military insignia.' --- Bob Apthorpe

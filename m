Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTKXRGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 12:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTKXRGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 12:06:00 -0500
Received: from main.gmane.org ([80.91.224.249]:14311 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263811AbTKXRF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 12:05:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Mon, 24 Nov 2003 18:05:53 +0100
Message-ID: <yw1x1xrxpuha.fsf@kth.se>
References: <200311241736.23824.jlell@JakobLell.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:zyyOU1LpjjB99nvSV2YUo10z/Xw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Lell <jlell@JakobLell.de> writes:

> on Linux it is possible for any user to create a hard link to a file
> belonging to another user. This hard link continues to exist even if
> the original file is removed by the owner. However, as the link
> still belongs to the original owner, it is still counted to his
> quota. If a malicious user creates hard links for every temp file
> created by another user, this can make the victim run out of quota
> (or even fill up the hard disk). This makes a local DoS attack
> possible.

This only make for a DoS attack if the there are user-writable
directories on a filesystem that the system depends on being writable.

> Furthermore, users can even create links to a setuid binary. If
> there is a security whole like a buffer overflow in any setuid
> binary, a cracker can create a hard link to this file in his home
> directory. This link still exists when the administrator has fixed
> the security whole by removing or replacing the insecure
> program. This makes it possible for a cracker to keep a security
> whole open until an exploit is available. It is even possible to
> create links to every setuid program on the system. This doesn't
> create new security holes but makes it more likely that they are
> exploited.

If any SUID user writable directories (/tmp, /var/various, /home) are
kept on separate partitions from any SUID executables (belonging in
/bin and /usr/bin), creating such links becomes impossible, and the
problem vanishes.

If a SUID program is found to have a security hole, the administrator
should make sure he removes all links to it when deleting it, just to
be safe.

-- 
Måns Rullgård
mru@kth.se


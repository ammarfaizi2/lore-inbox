Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVGUWEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVGUWEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGUWEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:04:55 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:44567 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261894AbVGUWEy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:04:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YajL9PvVOeWp7+CFLKQyGf1emFWr+0dQ2R+M4LIxcwia676uu50LhF501pm+68IOlroUXxArkQOdTQeVEQZPgYR3B2PIK6mKTKXQJGjMZZYmFOWwIGkFmBHtciWMXFyPablVXrZf0Y27c8k6nNLlEaR1NOZsqegObA1hh649LB0=
Message-ID: <9a87484905072115041cc576a4@mail.gmail.com>
Date: Fri, 22 Jul 2005 00:04:16 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen_/_Tronic?= 
	<tronic+lzID=lx43caky45@trn.iki.fi>
Subject: Re: CIFS slowness & crashes
Cc: linux-kernel@vger.kernel.org, Steve French <smfltc@us.ibm.com>,
       Steve French <sfrench@samba.org>
In-Reply-To: <42E01163.3090302@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42E01163.3090302@trn.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/05, Lasse Kärkkäinen / Tronic <tronic+lzID=lx43caky45@trn.iki.fi> wrote:
> I mailed sfrench@samba.org (the guy who wrote the driver) about this a
> month ago, but didn't get any reply. Is anyone working on that driver
> anymore?
> 
As far as I know Steve is still maintaining cifs. If you wrote him and
didn't get a response, then try again after a while (you might have
included him on CC for this mail) - maintainers don't always have time
to answer all mail in a timely fashion (or at all), and it's your
responsability to resend - that's not news.

You could also have written to the samba-technical@lists.samba.org
mailinglist (or copied it - it's listed in MAINTAINERS under "COMMON
INTERNET FILE SYSTEM (CIFS)").

[adding Stephen French to CC]

Personally I'd probably have send the mail
 To: Steve French <sfrench@samba.org>
 Cc: samba-technical@lists.samba.org
 Cc: linux-kernel@vger.kernel.org

> The problems that I wrote him about were:
> 
> 1. CIFS VFS hangs entirely if the server crashes or otherwise goes
> offline. Every process touching the mount halts too and cannot be killed
> (but they are not zombies). System loads start climbing and eventually
> the entire system will die (after system loads reach about 500). It is
> not possible to umount with either smbumount (hangs) nor umount -f
> (prints errors but doesn't umount anything). It won't recover without
> reboot, even if the server becomes back online.
> 
> This problem has been around as long as I have used SMBFS or CIFS. There
> has only been slight variation from one version to another. Sometimes it
> is possible to umount them (after some pretty long timeout), sometimes
> it is not. It seems as if the problem was being fixed, but none of the
> fixes really worked.
> 
> 2. Occassionally the transmission speeds go extremely low for no
> apparent reason. While writing this, I am getting 0.39 Mo/s over a
> gigabit network. Using FTP to read the same file gives 40 Mo/s, which is
> the speed that the file can be read locally on the server too.
> Remounting the CIFS does not help, nor does restarting Samba. However,
> using SMBFS I can get 20 Mo/s which is a bit better but still far from
> what it should be. It is important to mention that sometimes CIFS does
> work faster (about as quickly as SMBFS) and that this misbehavior occurs
> randomly.
> 
> During CIFS transfer, both computers seem to be idling. The CPU usage
> (including I/O wait) is almost none. During SMBFS transfer the server
> smbd process uses about 15 % CPU and the client is almost idle. The
> client is P4 3.4 GHz and the server is Athlon64 3000+.
> 
> I also tested with a Windows XP client machine and found out that this
> slowness issue does not happen with it, using the very same Samba server
> that the Linux CIFS mount is using.
> 
> - Tronic -
> 
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272780AbTHENEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272782AbTHENEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:04:05 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:8344 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272780AbTHEND6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:03:58 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 15:03:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805150351.5b81adfe.skraw@ithnet.com>
In-Reply-To: <3F2FA862.2070401@aitel.hist.no>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
	<03080416092800.04444@tabby>
	<20030805003210.2c7f75f6.skraw@ithnet.com>
	<3F2FA862.2070401@aitel.hist.no>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Aug 2003 14:51:46 +0200
Helge Hafting <helgehaf@aitel.hist.no> wrote:

> Even more fun is when you have a directory loop like this:
> 
> mkdir A
> cd A
> mkdir B
> cd B
> make hard link C back to A
> 
> cd ../..
> rmdir A
> 
> You now removed A from your home directory, but the
> directory itself did not disappear because it had
> another hard link from C in B.

How about a truly simple idea: 

rmdir A says "directory in use" and is rejected

Which means you simply cannot remove the first directory entry before not all
other links to it are removed. This implies only two things: 
1) you have to know who was first.
2) you have to be able to find out where the links are.

Both sound solvable.

Regards,
Stephan


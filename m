Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbQJ0UU6>; Fri, 27 Oct 2000 16:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbQJ0UUs>; Fri, 27 Oct 2000 16:20:48 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:262 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129609AbQJ0UUc>;
	Fri, 27 Oct 2000 16:20:32 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Date: Fri, 27 Oct 2000 22:18:27 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: NCPFS flags all files executable on NetWare Volumes wit
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <B2B7DE64537@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Oct 00 at 13:46, Jeff V. Merkey wrote:
> Here's the complete set of 3.x/4.x/5.x Namespace NCP calls with proper
> return codes.  I'll run down the huge-data info and post a bit later.

Thanks. Main problem with hardlinks is that unlink through NFS namespace
kills server (at least up to 5.0, I did not checked it during last few
months), and unlink through DOS (or OS2) namespace removes all instances 
of hardlinked file :-( A bit unfortunate behavior.
 
> let me know.  I have a 600 page document I wrote two years ago that
> details every single NCP and NDS NCP used,
> and can send it to you via UPS in .cz.   It's too big to fax, or post.

Not for now.

> 2222/6804       Return Bindery Context (you need to implement this one
> -- I did not see it in your code)

ncpfs 2.2.0.18 implements this (lib/ds/bindctx.c:NWDSGetBinderyContext),
but does not use it itself...

> 2222/6805       Monitor NDS Connection (this one will allow you to
> intercept NDS replica packets and suck an NDS replica local)

Novell documentation is a bit - hmm - unclear on this one...
 
> 2222/1631       Open Data Stream (this NCP will allow you to open the
> MAC namespace data fork and read it remotely for MAC clients)

Userspace ncpfs (specifically ncopy) uses 
(lib/filemgmt.c:ncp_ns_open_create_entry) NCP 87,30 or 87,33 for this
(and NW3.x is out of luck, AFAIK). Kernel code does not support MAC
forks (and ACL and extended attributes), as up to now there is no 
vfs API for this... You have to use ncopy,nwdir/nwrights,
nwtrustee,...,nwdir/eaops,nwdir for accessing MAC(&FTAM)/ACL/EAs for now.
(for EAs you must have post-August 27 ncpfs, betas are on
ftp://platan.vc.cvut.cz/private/ncpfs)
                                        Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

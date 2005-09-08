Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933033AbVIHDHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbVIHDHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 23:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbVIHDHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 23:07:48 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:4758 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S933033AbVIHDHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 23:07:46 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 00/10] parport: ieee1284 fixes and cleanups
Date: Wed, 7 Sep 2005 22:07:33 -0500
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Marko Kohtala <marko.kohtala@gmail.com>,
       linux-parport@lists.infradead.org
References: <20050905183109.284672000@kohtala.home.org> <9cfa10eb050907043443325b89@mail.gmail.com> <20050907045052.508a0b4f.akpm@osdl.org>
In-Reply-To: <20050907045052.508a0b4f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509072207.33725.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 September 2005 06:50, Andrew Morton wrote:
> Marko Kohtala <marko.kohtala@gmail.com> wrote:
> >
> > > You just sent ten patches, all with the same name.  This causes me grief
> >  > (See http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, section 2a).
> > 
> >  I used "quilt mail" to send those patches and it seems it requires
> >  some additional trick I did not notice to make the patches have
> >  different subjects.
> 
> I complained to the quilt guys about that and they did make a move to fix
> it, but I recall not being very happy with the proposal.  Anyway, make sure
> you have the latest version and check the documentation - it's in there
> somewhere.
> 
> As a last resort, put the title into the first line of the changelog and
> I'll cut-n-paste it.
>

I have the following in my .quiltrc

quilt_mail_patch_filter() {
        local x=$(cat)
        echo "$x" \
        | sed -n \
               -e 's/^\(To\|Cc\):/Recipient-\1:/ip' \
               -e 's/^Subject:/Replace-Subject:/p' \
               -e '/^\*\*\*\|---/q'
        echo
        # Discard the patch header, and pass on the rest
        echo "$x" | awk '
        !seen_from && (/^From: /) { print $0 "\n" ; seen_from = 1 }
        !in_body && (/^[-A-Za-z]+:/) { next }
        !in_body && (/^$/) { in_body = 1 ; next }
        { print }
        '
}

And I have my patches in the following form:

Subject: mail subject
From: <someone if not I, git uses it>

<area (Usually Input)>: Short patch description

Decsription

Signed-off-by: X XX
---
<patch>

Then quilt mail command seems to do the right thing.

-- 
Dmitry

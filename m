Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288622AbSADMeE>; Fri, 4 Jan 2002 07:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288620AbSADMd5>; Fri, 4 Jan 2002 07:33:57 -0500
Received: from ns.ithnet.com ([217.64.64.10]:13319 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288617AbSADMdt>;
	Fri, 4 Jan 2002 07:33:49 -0500
Date: Fri, 4 Jan 2002 13:33:21 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: andihartmann@freenet.de, riel@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020104133321.39287b2d.skraw@ithnet.com>
In-Reply-To: <3C351012.9B4D4D6@megsinet.net>
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com>
	<3C2F04F6.7030700@athlon.maya.org>
	<3C309CDC.DEA9960A@megsinet.net>
	<20011231185350.1ca25281.skraw@ithnet.com>
	<3C351012.9B4D4D6@megsinet.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jan 2002 20:14:42 -0600
"M.H.VanLeeuwen" <vanl@megsinet.net> wrote:
 
> Stephan,
> 
> Here is what I've run thus far.  I'll add nfs file copy into the mix also...

Ah, Martin, thanks for sending the patch. I think I saw the voodoo in your
patch. When I did that last time I did _not_ do this:

+                       if (PageReferenced(page)) {
+                               del_page_from_inactive_list(page);
+                               add_page_to_active_list(page);
+                       } 
+                       continue;

This may shorten your inactive list through consecutive runs.

And there is another difference here:

+       if (max_mapped <= 0 && nr_pages > 0)
+               swap_out(priority, gfp_mask, classzone);
+

It sounds reasonable _not_ to swap in case of success (nr_pages == 0).
To me this looks pretty interesting. Is something like this already in -aa?
This patch may be worth applying in 2.4. It is small and looks like the right
thing to do.

Regards,
Stephan



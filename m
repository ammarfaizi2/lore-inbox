Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754002AbWKGEbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbWKGEbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 23:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbWKGEbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 23:31:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:3213 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1754003AbWKGEbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 23:31:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WUm2qtmVCr4Pl5zfLEj8R7Yap7YfZj6mAffKVoCCltRgan3RLsowMN/sZRmvOdTwQ5nXTZzMXCkpfHvNJEDvnAsVUvepfEE64vXXArPGB6bbgm19VJh6jSZbRl0krC4hWRNqFtgasjYNY23lBgezoGgKHXnY9OqS7vTn9Eo//rY=
Message-ID: <610823610611062031m5dd3f258xe1c296d5794427f3@mail.gmail.com>
Date: Mon, 6 Nov 2006 23:31:10 -0500
From: "Andrew Wade" <andrew.j.wade@gmail.com>
Reply-To: ajwade@alumni.uwaterloo.ca
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Subject: Re: 2.6.19-rc4-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Kimball Murray" <kimball.murray@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A04A@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A04A@EXNA.corp.stratus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Richardson, Charlotte <Charlotte.Richardson@stratus.com> wrote:
...
> How much is each line offset when you have the garbled stuff? I mean,
> is it a couple pixels, half the total width, something else? And is
> it always the same for each line (or can you tell)?

Each ghost is 1/3 of a screen horizontally from the other ghosts. I've
been looking carefully at test patterns to figure out what is going on.

If

(1,1) (2,1) (3,1) (4,1) (5,1) (6,1) (7,1) (8,1)
(1,2) (2,2) (3,2) (4,2) (5,2) (6,2) (7,2) (8,2)
(1,3) (2,3) (3,3) (4,3) (5,3) (6,3) (7,3) (8,3)
(1,4) (2,4) (3,4) (4,4) (5,4) (6,4) (7,4) (8,4)
(1,5) (2,5) (3,5) (4,5) (5,5) (6,5) (7,5) (8,5)
(1,6) (2,6) (3,6) (4,6) (5,6) (6,6) (7,6) (8,6)

is what should be displayed, I'm getting instead

(1,1) (2,1) (3,1) black (4,1) (5,1) (6,1) black
(7,1) (8,1) (1,2) black (2,2) (3,2) (4,2) black
(5,2) (6,2) (7,2) black (8,2) (1,3) (2,3) black
(3,3) (4,3) (5,3) black (6,3) (7,3) (8,3) black
(1,4) (2,4) (3,4) black (4,4) (5,4) (6,4) black
(7,4) (8,4) (1,5) black (2,5) (3,5) (4,5) black

i.e., a black pixel is inserted every thee pixels.

However, it's not just a garbled display, the acceleration (I think) is
also bogus. When I tried setting a solid colour using echo -e '\e[47m',
instead of the above display, I got

(1,1) (2,1) (3,1) black (4,1) black black black
black black (1,2) black (2,2) (3,2) (4,2) black
black black black black black (1,3) (2,3) black
(3,3) (4,3) black black black black black black
(1,4) (2,4) (3,4) black (4,4) black black black
black black (1,5) black (2,5) (3,5) (4,5) black

i.e., in addition to a black pixel being inserted every three pixels,
one of the halves of the "source" image is black. And in the X virtual
console, the cursor is ungarbled.

Two other thing of note is that virtual consoles 2-6 are garbled after
only some boots. (vc7, the X server console, is always garbled). And
output below the as-displayed bottom of a garbled virtual console
prevents me from switching to a different vc. (I get "radeonfb FIFO
Timeout !"/"radeonfb Idle Timeout !" on the serial line).

Hope this helps,

ajw

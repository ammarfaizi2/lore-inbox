Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWEJOf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWEJOf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWEJOf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:35:27 -0400
Received: from main.gmane.org ([80.91.229.2]:30388 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751451AbWEJOf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:35:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ATI Remote Control improvements
Date: Wed, 10 May 2006 17:39:08 +0300
Message-ID: <pan.2006.05.10.14.39.06.406060@sci.fi>
References: <7B12C7CF8EB6734F9C50A406CD99BED23AD51D@mail01b.SEPURA.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181093116.pp.htv.fi
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006 09:12:23 +0100, Daniel Sherwood wrote:

> 
> Hi
> 
> Please find below a patch to improve the functionality of the ATI Remote
> Control as follows.
> 
> * Fixed handling of double-click BTN_XXX events that require the
> input_event timestamp to change between press and release events.
> * Added module parameter 'xkeycodesonly' to prevent driver generating
> keycodes that are not recognised by X windows. (disabled by default)

Why?

> * Added module parameter 'selectiverepeat' to make driver only generate
> key repeats for certain keys such and cursor and volume.  (disabled by
> default)

Sounds like this sort of thing could be handled in userspace.

> * Modified filter and key repate support to use millisecond values set
> by 'filtertime', 'repeatdelay' & 'repeatrate' module parameters.

REP_DELAY and REP_PERIOD?

> * Added module parameters 'mouseascursor' & 'mouseascursordefault' to
> allow the mouse area to behave as the normal cursor-keys.  This
> functionality can optionally be switched with the 'HAND' key.  (disabled
> by default)

IIRC it already has cursor keys. Why does it need more of them?

> * Added module parameter 'mousedoubleclick' to make the double-click
> events actually send two clicks of BTN_LEFT or BTN_RIGHT rather than
> BTN_SIDE or BTN_EXTRA.  (disabled by default)
> 
> Without specifying module options, the behaviour will be the same as the
> previous version except for the BTN_XXX click fix and the filter and key
> repeat handling.


> +			if (kind == KIND_BUTTON) {
> +				struct timeval then, now;
> +				int loop = 1000000;
> +				input_sync(dev);
> +				do_gettimeofday(&then);
> +				do {
> +					do_gettimeofday(&now);
> +				} while( timeval_compare(&now, &then) ==
> 0 && loop-- );

Is this for the timestamp thing? Use udelay()?

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/



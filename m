Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRKOA4d>; Wed, 14 Nov 2001 19:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279103AbRKOA4X>; Wed, 14 Nov 2001 19:56:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40637 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S278800AbRKOA4K>;
	Wed, 14 Nov 2001 19:56:10 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 15 Nov 2001 00:55:58 GMT
Message-Id: <UTC200111150055.AAA93544.aeb@cwi.nl>
To: adilger@turbolabs.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: generic_file_llseek() broken?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I _think_ there is a bug in generic_file_llseek(), with it returning -EINVAL
> instead of -EFBIG in the case where the offset is larger than the s_maxbytes.
> AFAICS, the return -EINVAL is for the case where "whence" is invalid, not the
> case where "offset" is too large for the underlying filesystem

My reading of the standards is:

[EFBIG] - File too large. You get this when trying to write. Not for a seek.
  The size of a file would exceed the maximum file size
  of an implementation or offset maximum established
  in the corresponding file description.

[EOVERFLOW] - Value too large for data type. This can happen for a seek.
  The resulting file offset would be a value which cannot be represented
  correctly in an object of the given type.

[EINVAL] - Bad value for other reasons. This will happen for a seek to a
  negative offset.

Andries

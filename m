Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933046AbWLFPEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWLFPEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbWLFPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:04:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:4191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046AbWLFPEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:04:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=F9dAax2kVc9wds3CcUeqYkJ5EQ71o9IfWdj3tTidHd9QeCbqgSOGXzQ7CFsLUql1Vhm61nl1VO8W8cx14RKqPBlKoeNHpTAOuCyTCyuzJ04OFRMAYdfDVh/+LEpQUaBQ7R7Yq+iaxRv8BQL88Y3Q3BYVxZTKFkJB0Nn0ET2kK5E=
Message-ID: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com>
Date: Wed, 6 Dec 2006 16:04:22 +0100
From: "Jan Blunck" <jblunck@suse.de>
To: "Phil Endecott" <phil_arcwk_endecott@chezphil.org>
Subject: Re: Subtleties of __attribute__((packed))
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1165411241721@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165411241721@dmwebmail.belize.chezphil.org>
X-Google-Sender-Auth: 2df2dcb737dadfc9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Phil Endecott <phil_arcwk_endecott@chezphil.org> wrote:
> Dear All,
>
> I used to think that this:
>
> struct foo {
>    int a  __attribute__((packed));
>    char b __attribute__((packed));
>    ... more fields, all packed ...
> };
>
> was exactly the same as this:
>
> struct foo {
>    int a;
>    char b;
>    ... more fields ...
> } __attribute__((packed));
>
> but it is not, in a subtle way.
>

The same code is generated. The difference is that usually packing the
whole struct isn't as error-prone as packing every element. Besides
that the gcc warns about packing objects that have an alignment of 1.
This is the reason why we should use the second approach.

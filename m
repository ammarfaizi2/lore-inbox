Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTDFVm5 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbTDFVm5 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:42:57 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:45188 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263113AbTDFVm4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:42:56 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 6 Apr 2003 14:52:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rik van Riel <riel@surriel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: subobj-rmap
In-Reply-To: <Pine.LNX.4.44.0304061737510.2296-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.50.0304061447560.7645-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0304061737510.2296-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, Rik van Riel wrote:

> On Sun, 6 Apr 2003, Martin J. Bligh wrote:
>
> > Supposing we keep a list of areas (hung from the address_space) that
> > describes independant linear ranges of memory that have the same set
> > of vma's mapping them (call those subobjects). Each subobject has a
> > chain of vma's from it that are mapping that subobject.
> >
> > address_space ---> subobject ---> subobject ---> subobject ---> subobject
> >                        |              |              |              |
> >                        v              v              v              v
> >                       vma            vma            vma            vma
> >                        |                             |              |
> >                        v                             v              v
> >                       vma                           vma            vma
> >                        |                             |
> >                        v                             v
> >                       vma                           vma
>
> OK, lets say we have a file of 1000 pages, or
> offsets 0 to 999, with the following mappings:
>
> VMA A:   0-999
> VMA B:   0-200
> VMA C: 150-400
> VMA D: 300-500
> VMA E: 300-500
> VMA F:   0-999
>
> How would you describe these with independant
> regions ?

You should decompose each VMA in a set on independent regions. Immagine to
pile up each VMA with boundaries that cuts each other VMA address space :

1) |----------------------|
2)     |-----------|
3) |--------------------------|
4)         |-----------|

R) |---|---|-------|---|--|---|

    1   1   1       1   1  3
    3   2   2       3   3
        3   3       4
            4



- Davide


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRAICMc>; Mon, 8 Jan 2001 21:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAICML>; Mon, 8 Jan 2001 21:12:11 -0500
Received: from 209.102.21.2 ([209.102.21.2]:41482 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S130196AbRAICMD>;
	Mon, 8 Jan 2001 21:12:03 -0500
Message-ID: <3A5A42F5.648BE730@goingware.com>
Date: Mon, 08 Jan 2001 22:45:09 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan (jjs@toyota.com) sez:

> This is a little OT for linux-kernel

Off-topic to debug a new kernel feature that will significantly add to the
competitiveness of Linux on the desktop and in engineering applications?

Remember, my original report was that DRI was reported to be working in before
the final 2.4.0 release, but stopped when the penguin peed on it, but now that
I've done what should be done to fix this, I don't have the results that others
are seeing.

While this may be due to problems with Mesa, XFree86 4.0.2, or the kernel, the
fact is that in our brave new world they operate as an integrated whole so it is
important to figure it out as a unit.  And I'm not really trying to play quake
here but QA the kernel in general - it was in noticing a discrepancy while
running the Mesa test suite that I got onto this, not because I care so much
about 3D performance.  I've yet to find a programmer's editor where 3D
performance makes much of a difference.

Comments posted here and received privately indicate that some get blazing speed
from 4.0.2 + 2.4.0, and some get, well, software speeds.  So there's a problem
to be worked out.

I've done what others have suggested, removing any GL libraries other than the
ones in /usr/X11R6/lib to make sure my applications used that one.

The build of the Mesa demos are hardwired to use the libraries from within the
source distribution directories.  If you take the gloss binary somewhere else,
delete those libraries, and make a link to the X11 GL library in /usr/lib, gloss
will run, at the amazing (and previously observed) frame rate of 7.5 FPS.

So that doesn't work.

glxinfo says dri is not available if I remove the library as I did.  So I
rebuilt Mesa and reinstalled it.  The full output of glxinfo on my machine
follows.  Note that it says "direct rendering: Yes" but the version strings
don't match.  Does that indicate the problem?

Server: 1.3 Mesa 3.4
Client: 1.2 Mesa 3.4
OpenGL: 1.2 Mesa 3.4

display: :0.0  screen:0
direct rendering: Yes
server glx vendor string: Brian Paul
server glx version string: 1.3 Mesa 3.4
server glx extensions:
    GLX_MESA_pixmap_colormap, GLX_EXT_visual_info, GLX_EXT_visual_rating, 
    GLX_MESA_release_buffers, GLX_MESA_copy_sub_buffer, GLX_SGI_video_sync, 
    GLX_ARB_get_proc_address
client glx vendor string: Brian Paul
client glx version string: 1.2 Mesa 3.4
client glx extensions:
    GLX_MESA_pixmap_colormap, GLX_EXT_visual_info, GLX_EXT_visual_rating, 
    GLX_MESA_release_buffers, GLX_MESA_copy_sub_buffer, GLX_SGI_video_sync, 
    GLX_ARB_get_proc_address
GLX extensions:
    GLX_MESA_pixmap_colormap, GLX_EXT_visual_info, GLX_EXT_visual_rating, 
    GLX_MESA_release_buffers, GLX_MESA_copy_sub_buffer, GLX_SGI_video_sync, 
    GLX_ARB_get_proc_address
OpenGL vendor string: Brian Paul
OpenGL renderer string: Mesa X11
OpenGL version string: 1.2 Mesa 3.4
OpenGL extensions:
    GL_ARB_multitexture, GL_ARB_texture_cube_map, GL_ARB_tranpose_matrix, 
    GL_EXT_abgr, GL_EXT_blend_color, GL_EXT_blend_func_separate, 
    GL_EXT_blend_logic_op, GL_EXT_blend_minmax, GL_EXT_blend_subtract, 
    GL_EXT_clip_volume_hint, GL_EXT_compiled_vertex_array, GL_EXT_histogram, 
    GL_EXT_packed_pixels, GL_EXT_paletted_texture, GL_EXT_point_parameters, 
    GL_EXT_polygon_offset, GL_EXT_rescale_normal, 
    GL_EXT_shared_texture_palette, GL_EXT_stencil_wrap, GL_EXT_texture3D, 
    GL_EXT_texture_env_add, GL_EXT_texture_env_combine, GL_EXT_texture_object, 
    GL_EXT_texture_lod_bias, GL_EXT_vertex_array, GL_HP_occlusion_test, 
    GL_INGR_blend_func_separate, GL_MESA_window_pos, GL_MESA_resize_buffers, 
    GL_NV_texgen_reflection, GL_PGI_misc_hints, GL_SGI_color_matrix, 
    GL_SGI_color_table, GL_SGIS_pixel_texture, GL_SGIS_texture_edge_clamp, 
    GL_SGIX_pixel_texture

   visual  x  bf lv rg d st colorbuffer ax dp st accumbuffer  ms  cav
 id dep cl sp sz l  ci b ro  r  g  b  a bf th cl  r  g  b  a ns b eat
----------------------------------------------------------------------
0x23 24 tc  0 24  0 r  .  .  8  8  8  0  0  0  0  0  0  0  0  0 0 None
0x24 24 tc  0 24  0 r  y  .  8  8  8  0  0 16  8 16 16 16 16  0 0 None
0x25 24 tc  0 24  0 r  y  .  8  8  8  0  0 16  8 16 16 16 16  0 0 None
0x26 24 tc  0 24  0 r  y  .  8  8  8  0  0 16  8 16 16 16 16  0 0 None
0x27 24 dc  0 24  0 r  y  .  8  8  8  0  0 16  8 16 16 16 16  0 0 None
0x28 24 dc  0 24  0 r  y  .  8  8  8  0  0 16  8 16 16 16 16  0 0 None
0x29 24 dc  0 24  0 r  y  .  8  8  8  0  0 16  8 16 16 16 16  0 0 None
0x2a 24 dc  0 24  0 r  y  .  8  8  8  0  0 16  8 16 16 16 16  0 0 None

-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
